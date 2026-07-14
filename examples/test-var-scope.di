<!--
  Test variable scope and substitution
-->
<dirac>
  <!-- Define a subroutine that takes parameters -->
  <subroutine name="test-sub" param-token="string" param-chat_id="string" param-message="string">
    <output>[test-sub] Token: <variable name="token" /></output>
    <output>[test-sub] Chat ID: <variable name="chat_id" /></output>
    <output>[test-sub] Message: <variable name="message" /></output>
  </subroutine>
  
  <!-- Test 1: Direct values -->
  <output>=== Test 1: Direct values ===</output>
  <call name="test-sub" token="abc123" chat_id="999" message="hello" />
  
  <!-- Test 2: Variables with defvar at top level -->
  <output>
=== Test 2: Variables with defvar ===</output>
  <defvar name="my_token" value="def456" />
  <defvar name="my_chat" value="888" />
  <defvar name="my_msg" value="world" />
  <output>Before call: my_token=<variable name="my_token" /></output>
  <call name="test-sub" token="${my_token}" chat_id="${my_chat}" message="${my_msg}" />
  
  <!-- Test 3: Variables defined inside <then> block -->
  <output>
=== Test 3: Variables in then block ===</output>
  <defvar name="condition" value="true" />
  <if>
    <expr eval="eq">
      <arg><variable name="condition" /></arg>
      <arg>true</arg>
    </expr>
    <then>
      <defvar name="inner_token" value="ghi789" />
      <defvar name="inner_chat" value="777" />
      <defvar name="inner_msg" value="from inside" />
      <output>Inside then: inner_token=<variable name="inner_token" /></output>
      <call name="test-sub" token="${inner_token}" chat_id="${inner_chat}" message="${inner_msg}" />
    </then>
  </if>
  
  <!-- Test 4: Outer variables accessed from inside then block -->
  <output>
=== Test 4: Outer variables from inside then ===</output>
  <defvar name="outer_token" value="jkl012" />
  <defvar name="outer_chat" value="666" />
  <if>
    <expr eval="eq">
      <arg><variable name="condition" /></arg>
      <arg>true</arg>
    </expr>
    <then>
      <defvar name="outer_msg" value="mixed scope" />
      <output>Inside then: outer_token=<variable name="outer_token" /></output>
      <call name="test-sub" token="${outer_token}" chat_id="${outer_chat}" message="${outer_msg}" />
    </then>
  </if>
</dirac>
