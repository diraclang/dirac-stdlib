<!--
  Test parameter passing with exact bot-listener scenario
-->
<dirac>
  <subroutine name="test-params" param-token="string" param-chat_id="string" param-message="string">
    <!-- Simulate telegram.di logic -->
    <defvar name="bot_token" trim="true"><environment name="TELEGRAM_BOT_TOKEN" /></defvar>
    <defvar name="chat_id_env" trim="true"><environment name="TELEGRAM_CHAT_ID" /></defvar>
    
    <output>[test-params] From environment:</output>
    <output>  bot_token from env: '<variable name="bot_token" />'</output>
    <output>  chat_id_env from env: '<variable name="chat_id_env" />'</output>
    
    <output>[test-params] Parameters:</output>
    <output>  token param: '<variable name="token" />'</output>
    <output>  chat_id param: '<variable name="chat_id" />'</output>
    <output>  message param: '<variable name="message" />'</output>
    
    <!-- Override with params if provided -->
    <test-if test="$token" ne="">
      <assign name="bot_token"><variable name="token" /></assign>
      <output>  -> bot_token overridden to: '<variable name="bot_token" />'</output>
    </test-if>
    
    <test-if test="$chat_id" ne="">
      <assign name="chat_id_env"><variable name="chat_id" /></assign>
      <output>  -> chat_id_env overridden to: '<variable name="chat_id_env" />'</output>
    </test-if>
    
    <output>[test-params] Final values:</output>
    <output>  bot_token: '<variable name="bot_token" />'</output>
    <output>  chat_id_env: '<variable name="chat_id_env" />'</output>
  </subroutine>
  
  <!-- Simulate bot-listener scenario -->
  <output>=== Simulating bot-listener scenario ===</output>
  
  <!-- Outer scope variables (like bot-listener has) -->
  <defvar name="bot_token" value="outer_token_value" />
  
  <!-- Simulate then block -->
  <defvar name="condition" value="true" />
  <if>
    <expr eval="eq">
      <arg><variable name="condition" /></arg>
      <arg>true</arg>
    </expr>
    <then>
      <!-- Variables defined in then (like chat_id in bot-listener) -->
      <defvar name="chat_id" value="12345" />
      <defvar name="response" value="test message" />
      
      <output>Before call:</output>
      <output>  bot_token: '<variable name="bot_token" />'</output>
      <output>  chat_id: '<variable name="chat_id" />'</output>
      <output>  response: '<variable name="response" />'</output>
      
      <output>
Calling test-params...</output>
      <call name="test-params" 
        token="${bot_token}"
        chat_id="${chat_id}"
        message="${response}" />
    </then>
  </if>
</dirac>
