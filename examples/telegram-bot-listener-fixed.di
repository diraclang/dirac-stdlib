<!--
  Telegram Bot Listener - Responds to incoming messages
  
  This bot:
  1. Polls for new messages every few seconds
  2. Responds to commands like /start, /help
  3. Echoes back any text message
  
  Prerequisites:
  - Set TELEGRAM_BOT_TOKEN environment variable
-->
<dirac>
  <import src="../lib/telegram.di" />
  <import src="../../dirac-json/lib/index.di" />
  
  <!-- Configuration -->
  <defvar name="bot_token" trim="true"><environment name="TELEGRAM_BOT_TOKEN" /></defvar>
  <defvar name="last_update_id" value="0" />
  <defvar name="poll_interval" value="5" />  <!-- Increased from 2 to 5 seconds to avoid task overlap -->
  
  <!-- Variables for message parsing -->
  <defvar name="update_id" value="0" />
  <defvar name="chat_id" value="0" />
  <defvar name="message_text" value="" />
  <defvar name="sender_name" value="" />
  
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
   <schedule interval="$poll_interval" name="telegram-bot-listener"> 
    <!-- Build URL using DIRAC string operations, not eval -->
    <defvar name="updates_url">https://api.telegram.org/bot<variable name="bot_token" />/getUpdates?offset=<variable name="last_update_id" />&amp;timeout=1</defvar>
    
    <!-- Get updates from Telegram using system command -->
    <defvar name="updates"><system>curl -s "<variable name="updates_url" />"</system></defvar>
    
    <!-- Check if we got any messages -->
    <if>
      <expr eval="contains">
        <arg><variable name="updates" /></arg>
        <arg>"message"</arg>
      </expr>
      <then>
        <output>[bot] Received message!</output>
        
        <!-- Use JSON library to extract values directly from the updates string -->
        <assign name="update_id">
          <json name="updates">
            <get jsonPath="result[0].update_id" />
          </json>
        </assign>
        
        <assign name="chat_id">
          <json name="updates">
            <get jsonPath="result[0].message.chat.id" />
          </json>
        </assign>
        
        <assign name="message_text">
          <json name="updates">
            <get jsonPath="result[0].message.text" />
          </json>
        </assign>
        
        <assign name="sender_name">
          <json name="updates">
            <get jsonPath="result[0].message.from.first_name" />
          </json>
        </assign>
    
        <output>[bot] From: <variable name="sender_name" /> (Chat ID: <variable name="chat_id" />)</output>
        <output>[bot] Message: <variable name="message_text" /></output>
    
        <!-- Process commands -->
        <defvar name="response"  />
        
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
          <defvar name="current_time">
            <system>date</system>
          </defvar>
          <assign name="response">Current time: <variable name="current_time" /></assign>
        </test-if>
      
        <test-if test="$message_text" eq="/status">
          <assign name="response">✅ Bot is running!
Update ID: <variable name="update_id" />
Polling interval: <variable name="poll_interval" />s</assign>
        </test-if>
      
        <!-- Default: echo the message -->

        <test-if test="$response" eq="">
          <assign name="response"><llm execute="true" save-dialog="true"><variable name="message_text" /></llm></assign>
        </test-if>
      
        <!-- Send response -->
        <output>[bot] Sending response...</output>
        <send-telegram-message
          token="$bot_token"
          chat_id="$chat_id"
          message="$response" />
      
        <!-- Update last_update_id to avoid processing same message again -->
        <assign name="last_update_id" trim="true">
          <expr eval="plus">
            <arg><variable name="update_id" /></arg>
            <arg>1</arg>
          </expr>
        </assign>
        <output>[bot] Updated last_update_id to: <variable name="last_update_id" /></output>
      </then>
    </if>
  </schedule>
</dirac>
