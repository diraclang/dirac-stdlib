<!-- TEST: string_includes_true -->
<!-- EXPECT: true -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="INCLUDES" str="hello world" search="world"/>
</dirac>
