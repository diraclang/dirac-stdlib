<!-- TEST: string_indexof_not_found -->
<!-- EXPECT: -1 -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="INDEXOF" str="hello world" search="xyz"/>
</dirac>
