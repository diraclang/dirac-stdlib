<!--
  Direct test with hardcoded credentials
  Replace YOUR_TOKEN and YOUR_CHAT_ID below
-->
<dirac>
  <import src="../lib/telegram.di" />
  
  <!-- Direct call with credentials -->
  <call name="send-telegram-message" 
    token="8655758922:AAF3jOa_XhSwemSh1Nj1UiPxrXJRAUlHOQE"
    chat_id="8329633840"
    message="Test message from Dirac!" />
</dirac>
