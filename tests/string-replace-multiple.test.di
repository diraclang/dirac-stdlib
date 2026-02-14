<!-- TEST: string_replace_multiple -->
<!-- EXPECT: hey hey hey -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="REPLACE" str="hi hi hi" search="hi" replace="hey"/>
</dirac>
