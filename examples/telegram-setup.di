<!--
  Telegram Setup and Test
  
  Follow these steps to set up Telegram messaging:
-->
<dirac>
  <output>
===========================================
Telegram Bot Setup Instructions
===========================================

1. Install Telegram (if not already installed)
   - iOS: App Store
   - Android: Google Play
   - Desktop: https://telegram.org/apps

2. Create Your Bot:
   a. Open Telegram and search for: @BotFather
   b. Send: /newbot
   c. Choose a name (e.g., "My Monitoring Bot")
   d. Choose a username (e.g., "my_monitoring_bot")
   e. Copy the token that looks like:
      123456789:ABCdefGHIjklMNOpqrsTUVwxyz

3. Get Your Chat ID:
   a. Send any message to your new bot
   b. Visit this URL in your browser (replace TOKEN):
      https://api.telegram.org/botTOKEN/getUpdates
   c. Look for "chat":{"id":YOUR_CHAT_ID}
   d. Copy the numeric ID

4. Set Environment Variables:
   export TELEGRAM_BOT_TOKEN="your-token-here"
   export TELEGRAM_CHAT_ID="your-chat-id-here"

5. Run this script again to test!

===========================================
  </output>
  
  <!-- Check if environment variables are set -->
  <environment name="bot_token" var="TELEGRAM_BOT_TOKEN" />
  <environment name="chat_id" var="TELEGRAM_CHAT_ID" />
  
  <test-if test="$bot_token" eq="">
    <output>❌ TELEGRAM_BOT_TOKEN not set. Follow instructions above.</output>
  </test-if>
  
  <test-if test="$chat_id" eq="">
    <output>❌ TELEGRAM_CHAT_ID not set. Follow instructions above.</output>
  </test-if>
  
  <!-- If both are set, run tests -->
  <test-if test="$bot_token" ne="">
    <test-if test="$chat_id" ne="">
      <output>
✅ Environment variables are set!
Testing Telegram integration...

      </output>
      
      <!-- Load telegram library -->
      <import src="../dirac-stdlib/lib/telegram.di" />
      
      <!-- Test 1: Simple message -->
      <output>Test 1: Sending simple message...</output>
      <call name="send-telegram-message" message="Hello from Dirac! 🎉" />
      
      <!-- Test 2: Markdown message -->
      <output>
Test 2: Sending markdown message...</output>
      <call name="send-telegram-markdown" message="*Bold text* and _italic text_

```
Code block example
```

[Link to Dirac](https://github.com/yourusername/dirac)" />
      
      <!-- Test 3: Alert messages -->
      <output>
Test 3: Sending alert messages...</output>
      <call name="send-telegram-alert" 
        level="info" 
        title="Information"
        details="This is an informational alert" />
      
      <call name="send-telegram-alert" 
        level="warning" 
        title="Warning Alert"
        details="This is a warning - something needs attention" />
      
      <call name="send-telegram-alert" 
        level="success" 
        title="Success"
        details="Operation completed successfully!" />
      
      <output>

✅ All tests complete! Check your Telegram app for messages.
      </output>
    </test-if>
  </test-if>
</dirac>
