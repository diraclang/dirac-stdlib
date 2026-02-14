<!-- TEST: string_join_no_delimiter -->
<!-- EXPECT: helloworld -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="JOIN" items="hello
world"/>
</dirac>
