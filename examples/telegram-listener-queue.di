<!--
  Telegram Bot Listener - Queue-based version
  
  This version:
  1. Polls Telegram for messages
  2. Sends message data to telegram-incoming queue
  3. No LLM processing here - that's done by workers
-->
<dirac>
  <import src="dirac-json/lib/index.di" />
  <import src="dirac-flow/lib/flow.di" />
  
  <!-- Configuration -->
  <defvar name="bot_token" trim="true"><environment name="TELEGRAM_BOT_TOKEN" /></defvar>
  <defvar name="last_update_id" value="0" />
  <defvar name="poll_interval" value="5" />
  
  <test-if test="$bot_token" eq="">
    <throw message="TELEGRAM_BOT_TOKEN not set" />
  </test-if>
  
  <!-- Define queue -->
  <queue name="telegram-incoming" dir="/Users/zhiwang/diraclang/dirac-flow/examples/queues" />
  
  <output>
🤖 Telegram Bot Listener (Queue Mode)
================================
Bot token: ✓ Set
Queue: telegram-incoming
Polling every <variable name="poll_interval" /> seconds

Listening for messages...
  </output>
  
  <!-- Schedule the polling task -->
  <schedule interval="$poll_interval" name="telegram-bot-listener">
    <!-- Build URL -->
    <defvar name="updates_url">https://api.telegram.org/bot<variable name="bot_token" />/getUpdates?offset=<variable name="last_update_id" />&amp;timeout=1</defvar>
    
    <!-- Get updates from Telegram -->
    <defvar name="updates"><system>curl -s "<variable name="updates_url" />"</system></defvar>
    
    <!-- Check if we got any messages -->
    <if>
      <expr eval="contains">
        <arg><variable name="updates" /></arg>
        <arg>"message"</arg>
      </expr>
      <then>
        <!-- Extract message data -->
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
        
        <output>📨 Received from <variable name="sender_name" /> (chat: <variable name="chat_id" />): <variable name="message_text" /></output>
        
        <!-- Send to queue using queue-send -->
        <queue-send queue="telegram-incoming" dir="../dirac-flow/examples/queues">
          &lt;message chat_id="<variable name="chat_id" />" text="<variable name="message_text" />" sender="<variable name="sender_name" />" &gt;
          <variable name="message_text" />&lt;message&gt;
        </queue-send>
        
        <output>✅ Sent to telegram-incoming queue</output>
        
        <!-- Update last_update_id -->
        <assign name="last_update_id" trim="true">
          <expr eval="plus">
            <arg><variable name="update_id" /></arg>
            <arg>1</arg>
          </expr>
        </assign>
      </then>
    </if>
  </schedule>
</dirac>
