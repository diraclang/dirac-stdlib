<!--
  Telegram Messaging Library
  
  Setup Instructions:
  1. Install Telegram on your phone/desktop
  2. Open Telegram and search for @BotFather
  3. Send /newbot and follow prompts to create your bot
  4. Copy the bot token (looks like: 123456789:ABCdefGHIjklMNOpqrsTUVwxyz)
  5. Send a message to your bot (any message)
  6. Get your chat ID by visiting:
     https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates
     Look for "chat":{"id":123456789} in the response
  7. Set environment variables:
     export TELEGRAM_BOT_TOKEN="your-bot-token"
     export TELEGRAM_CHAT_ID="your-chat-id"
-->

<!-- Send a simple text message to Telegram -->
<subroutine name="send-telegram-message"
  param-message="string"
  param-token="string (optional)"
  param-chat_id="string (optional)">
  
  <!-- Get from environment variables first -->
  <defvar name="bot_token" trim="true"><environment name="TELEGRAM_BOT_TOKEN" /></defvar>
  <defvar name="chat_id_env" trim="true"><environment name="TELEGRAM_CHAT_ID" /></defvar>
  
  <!-- Override with params if provided (params are: token, chat_id, message) -->
  <test-if test="$token" ne="">
    <assign name="bot_token"><variable name="token" /></assign>
  </test-if>
  
  <test-if test="$chat_id" ne="">
    <assign name="chat_id_env"><variable name="chat_id" /></assign>
  </test-if>
  
  <!-- Validate required parameters -->
  <test-if test="$bot_token" eq="">
    <throw message="TELEGRAM_BOT_TOKEN not set. Use token parameter or environment variable." />
  </test-if>
  
  <test-if test="$chat_id_env" eq="">
    <throw message="TELEGRAM_CHAT_ID not set. Use chat_id parameter or environment variable." />
  </test-if>
  
  <!-- Debug output -->
  <output>[telegram] Using bot token: <variable name="bot_token" /></output>
  <output>[telegram] Sending to chat ID: <variable name="chat_id_env" /></output>
  
  <!-- URL encode the message -->
  <eval name="encoded_message">
    return encodeURIComponent(message);
  </eval>
  
  <!-- Build API URL -->
  <defvar name="api_url" trim="true" >https://api.telegram.org/bot<variable name="bot_token" />/sendMessage</defvar>
  <output>[telegram] API URL: <variable name="api_url" /></output>
  
  <!-- Send message via curl -->
  <system output="response" trim="true">
    curl -s -X POST "<variable name="api_url" />" \
      -d "chat_id=<variable name="chat_id_env" />" \
      -d "text=<variable name="encoded_message" />"
  </system>
  
  <!-- Check for success -->
  <test-if test="$response" contains='"ok":true'>
    <output>[telegram] Message sent successfully</output>
  </test-if>
  
  <test-if test="$response" contains='"ok":false'>
    <output>[telegram] Error sending message: <variable name="response" /></output>
  </test-if>
</subroutine>

<!-- Send a formatted message with markdown -->
<subroutine name="send-telegram-markdown"
  param-message="string"
  param-token="string (optional)"
  param-chat_id="string (optional)">
  
  <defvar name="bot_token" value="${token}" />
  <defvar name="chat_id" value="${chat_id}" />
  
  <test-if test="$bot_token" eq="">
    <environment name="bot_token" var="TELEGRAM_BOT_TOKEN" />
  </test-if>
  
  <test-if test="$chat_id" eq="">
    <environment name="chat_id" var="TELEGRAM_CHAT_ID" />
  </test-if>
  
  <test-if test="$bot_token" eq="">
    <throw message="TELEGRAM_BOT_TOKEN not set" />
  </test-if>
  
  <test-if test="$chat_id" eq="">
    <throw message="TELEGRAM_CHAT_ID not set" />
  </test-if>
  
  <eval name="encoded_message">
    encodeURIComponent(message)
  </eval>
  
  <assign name="api_url">https://api.telegram.org/bot<variable name="bot_token" />/sendMessage</assign>
  
  <system output="response" trim="true">
    curl -s -X POST "<variable name="api_url" />" \
      -d "chat_id=<variable name="chat_id" />" \
      -d "text=<variable name="encoded_message" />" \
      -d "parse_mode=Markdown"
  </system>
  
  <test-if test="$response" contains='"ok":true'>
    <output>[telegram] Markdown message sent successfully</output>
  </test-if>
  
  <test-if test="$response" contains='"ok":false'>
    <output>[telegram] Error: <variable name="response" /></output>
  </test-if>
</subroutine>

<!-- Send alert with emoji and formatting -->
<subroutine name="send-telegram-alert"
  param-level="string"
  param-title="string"
  param-details="string"
  param-token="string (optional)"
  param-chat_id="string (optional)">
  
  <!-- Choose emoji based on alert level -->
  <defvar name="emoji" value="ℹ️" />
  <test-if test="$level" eq="warning">
    <assign name="emoji" value="⚠️" />
  </test-if>
  <test-if test="$level" eq="error">
    <assign name="emoji" value="❌" />
  </test-if>
  <test-if test="$level" eq="critical">
    <assign name="emoji" value="🚨" />
  </test-if>
  <test-if test="$level" eq="success">
    <assign name="emoji" value="✅" />
  </test-if>
  
  <!-- Get current timestamp -->
  <system output="timestamp" trim="true">date "+%Y-%m-%d %H:%M:%S"</system>
  
  <!-- Format message with markdown -->
  <assign name="formatted_message"><variable name="emoji" /> *<variable name="title" />*

*Level:* <variable name="level" />
*Time:* <variable name="timestamp" />

<variable name="details" /></assign>
  
  <!-- Send via markdown subroutine -->
  <call name="send-telegram-markdown" message="${formatted_message}" token="${token}" chat_id="${chat_id}" />
</subroutine>
