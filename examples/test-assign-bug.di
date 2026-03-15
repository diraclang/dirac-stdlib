<!--
  Test assign with variable
-->
<dirac>
  <subroutine name="test-assign" param-myvar="string">
    <output>[test-assign] myvar param: '<variable name="myvar" />'</output>
    
    <!-- Method 1: assign with variable element -->
    <assign name="result1"><variable name="myvar" /></assign>
    <output>Method 1 (variable element): '<variable name="result1" />'</output>
    
    <!-- Method 2: assign with value attribute -->
    <assign name="result2" value="${myvar}" />
    <output>Method 2 (value attribute): '<variable name="result2" />'</output>
    
    <!-- Method 3: Direct output to verify myvar exists -->
    <output>Direct output: '<variable name="myvar" />'</output>
  </subroutine>
  
  <call name="test-assign" myvar="hello world" />
</dirac>
