<!-- TEST: string_substring_no_length -->
<!-- EXPECT: world -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="SUBSTRING" str="hello world" start="6"/>
</dirac>
