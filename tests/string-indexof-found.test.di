<!-- TEST: string_indexof_found -->
<!-- EXPECT: 6 -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="INDEXOF" str="hello world" search="world"/>
</dirac>
