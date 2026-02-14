<!-- TEST: string_concat_basic -->
<!-- EXPECT: helloworld -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="CONCAT" str1="hello" str2="world"/>
</dirac>
