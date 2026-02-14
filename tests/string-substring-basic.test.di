<!-- TEST: string_substring_basic -->
<!-- EXPECT: llo -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="SUBSTRING" str="hello world" start="2" length="3"/>
</dirac>
