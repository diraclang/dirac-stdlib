<!--
  Test defvar with environment
-->
<dirac>
  <subroutine name="show-token" param-token="string">
    <output>[show-token] Token: '<variable name="token" />'</output>
    <output>[show-token] Token is: <test-if test="$token" eq="">EMPTY</test-if><test-if test="$token" ne="">NOT EMPTY</test-if></output>
  </subroutine>
  
  <!-- Test 1: Get environment variable -->
  <output>=== Test 1: Get TELEGRAM_BOT_TOKEN ===</output>
  <defvar name="bot_token1" trim="true"><environment name="TELEGRAM_BOT_TOKEN" /></defvar>
  <output>bot_token1: '<variable name="bot_token1" />'</output>
  <output>Is empty? <test-if test="$bot_token1" eq="">YES</test-if><test-if test="$bot_token1" ne="">NO</test-if></output>
  
  <!-- Test 2: Pass to subroutine -->
  <output>
=== Test 2: Pass to subroutine ===</output>
  <call name="show-token" token="${bot_token1}" />
  
  <!-- Test 3: Inside then block -->
  <output>
=== Test 3: Inside then block ===</output>
  <defvar name="condition" value="true" />
  <if>
    <expr eval="eq">
      <arg><variable name="condition" /></arg>
      <arg>true</arg>
    </expr>
    <then>
      <output>Inside then: bot_token1='<variable name="bot_token1" />'</output>
      <call name="show-token" token="${bot_token1}" />
    </then>
  </if>
</dirac>
