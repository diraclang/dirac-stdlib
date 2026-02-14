<!-- TEST: string_includes_false -->
<!-- EXPECT: false -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="INCLUDES" str="hello world" search="xyz"/>
</dirac>
