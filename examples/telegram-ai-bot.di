<!--
  Telegram AI Assistant Bot
  
  This bot:
  - Listens for messages
  - Sends them to LLM for processing
  - Returns AI-generated responses
  
  Prerequisites:
  - TELEGRAM_BOT_TOKEN set
  - LLM configured in dirac config.yml
-->
<dirac>
  <import src="../lib/telegram.di" />
  
  <environment name="bot_token" var="TELEGRAM_BOT_TOKEN" />
  <defvar name="last_update_id" value="0" />
  
  <test-if test="$bot_token" eq="">
    <throw message="TELEGRAM_BOT_TOKEN not set" />
  </test-if>
  
  <output>🤖 AI Assistant Bot Started - Powered by LLM</output>
  
  <schedule interval="2" name="ai-bot">
    <system output="updates" trim="true">
      curl -s "https://api.telegram.org/bot<variable name="bot_token" />/getUpdates?offset=<variable name="last_update_id" />&amp;timeout=1"
    </system>
    
    <test-if test="$updates" contains='"message"'>
      <!-- Extract message details -->
      <system output="update_id" trim="true">
        echo '<variable name="updates" />' | grep -o '"update_id":[0-9]*' | head -1 | cut -d: -f2
      </system>
      
      <system output="chat_id" trim="true">
        echo '<variable name="updates" />' | grep -o '"chat":{"id":[0-9]*' | head -1 | cut -d: -f3
      </system>
      
      <system output="message_text" trim="true">
        echo '<variable name="updates" />' | grep -o '"text":"[^"]*"' | head -1 | cut -d'"' -f4
      </system>
      
      <output>[AI] Processing: <variable name="message_text" /></output>
      
      <!-- Send to LLM -->
      <llm output="ai_response">
You are a helpful AI assistant in a Telegram chat. Be concise and friendly.

User message: <variable name="message_text" />

Respond helpfully:
      </llm>
      
      <!-- Send AI response back -->
      <call name="send-telegram-message" 
        token="${bot_token}"
        chat_id="${chat_id}"
        message="${ai_response}" />
      
      <!-- Update offset -->
      <assign name="last_update_id">
        <expr eval="plus">
          <arg><variable name="update_id" /></arg>
          <arg>1</arg>
        </expr>
      </assign>
    </test-if>
  </schedule>
</dirac>
