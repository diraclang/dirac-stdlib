<!--
  Test variable tag output
-->
<dirac>
  <defvar name="test" value="hello" />
  
  <output>Direct: <variable name="test" /></output>
  
  <defvar name="captured">
    <variable name="test" />
  </defvar>
  
  <output>Captured: '<variable name="captured" />'</output>
</dirac>
