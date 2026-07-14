<!--
  Telegram Bot Listener - Responds to incoming messages
  
  This bot:
  1. Polls for new messages every few seconds
  2. Responds to commands like /start, /help
  3. Echoes back any text message
  
  Prerequisites:
  - Set TELEGRAM_BOT_TOKEN environment variable
  - Set TELEGRAM_CHAT_ID environment variable (optional, will respond to any chat)
-->
<dirac>
  <import src="../lib/telegram.di" />
  
  <!-- Configuration -->
  <environment name="bot_token" var="TELEGRAM_BOT_TOKEN" />
  <defvar name="last_update_id" value="0" />
  <defvar name="poll_interval" value="2" />
  
  <test-if test="$bot_token" eq="">
    <throw message="TELEGRAM_BOT_TOKEN not set" />
  </test-if>
  
  <output>
🤖 Telegram Bot Listener Started
================================
Polling for messages every <variable name="poll_interval" /> seconds

Commands:
  :tasks   - Show running tasks
  :stopall - Stop the bot
  :exit    - Exit

Send messages to your bot in Telegram!
================================
  </output>
  
  <!-- Schedule the polling task -->
  <schedule interval="${poll_interval}" name="telegram-bot-listener">
    <!-- Get updates from Telegram -->
    <defvar name="updates" trim="true><system>
      curl -s "https://api.telegram.org/bot<variable name="bot_token" />/getUpdates?offset=<variable name="last_update_id" />&amp;timeout=1"
    </system></defvar>
    
    <!-- Check if we got any messages -->
    <test-if test="$updates" contains='"result":[]'>
      <!-- No new messages -->
    </test-if>
    
    <test-if test="$updates" contains='"message"'>
      <output>
[bot] Received message!</output>
      
      <!-- Parse the response to extract message details -->
      <!-- Get update_id -->
      <system output="update_id" trim="true">
        echo '<variable name="updates" />' | grep -o '"update_id":[0-9]*' | head -1 | cut -d: -f2
      </system>
      
      <!-- Get chat_id -->
      <system output="chat_id" trim="true">
        echo '<variable name="updates" />' | grep -o '"chat":{"id":[0-9]*' | head -1 | cut -d: -f3
      </system>
      
      <!-- Get message text -->
      <system output="message_text" trim="true">
        echo '<variable name="updates" />' | grep -o '"text":"[^"]*"' | head -1 | cut -d'"' -f4
      </system>
      
      <!-- Get sender name -->
      <system output="sender_name" trim="true">
        echo '<variable name="updates" />' | grep -o '"first_name":"[^"]*"' | head -1 | cut -d'"' -f4
      </system>
      
      <output>[bot] From: <variable name="sender_name" /> (Chat ID: <variable name="chat_id" />)</output>
      <output>[bot] Message: <variable name="message_text" /></output>
      
      <!-- Process commands -->
      <defvar name="response" value="" />
      
      <test-if test="$message_text" eq="/start">
        <assign name="response">Hello! 👋 I'm your Dirac bot. Send me any message and I'll echo it back!</assign>
      </test-if>
      
      <test-if test="$message_text" eq="/help">
        <assign name="response">Available commands:
/start - Start the bot
/help - Show this help
/time - Get current time
/status - Bot status

Or just send me any text and I'll echo it!</assign>
      </test-if>
      
      <test-if test="$message_text" eq="/time">
        <system output="current_time" trim="true">date</system>
        <assign name="response">Current time: <variable name="current_time" /></assign>
      </test-if>
      
      <test-if test="$message_text" eq="/status">
        <assign name="response">✅ Bot is running!
Update ID: <variable name="update_id" />
Polling interval: <variable name="poll_interval" />s</assign>
      </test-if>
      
      <!-- Default: echo the message -->
      <test-if test="$response" eq="">
        <assign name="response">You said: <variable name="message_text" /></assign>
      </test-if>
      
      <!-- Send response -->
      <output>[bot] Sending response...</output>
      <call name="send-telegram-message" 
        token="${bot_token}"
        chat_id="${chat_id}"
        message="${response}" />
      
      <!-- Update last_update_id to avoid processing same message again -->
      <assign name="last_update_id">
        <expr eval="plus">
          <arg><variable name="update_id" /></arg>
          <arg>1</arg>
        </expr>
      </assign>
    </test-if>
  </schedule>
</dirac>
