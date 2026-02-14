<!-- TEST: string_replace_basic -->
<!-- EXPECT: hello universe -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="REPLACE" str="hello world" search="world" replace="universe"/>
</dirac>
