<!--
  Simple Telegram Message Example
  
  Send a quick message to your Telegram bot
-->
<dirac>
  <!-- Import the telegram library -->
  <import src="../lib/telegram.di" />
  
  <!-- Send a simple message -->
  <call name="send-telegram-message" 
    message="Hello from Dirac! This is a test message." />
  
  <output>Message sent! Check your Telegram app.</output>
</dirac>
