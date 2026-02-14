<!-- TEST: string_trim_basic -->
<!-- EXPECT: hello -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="TRIM" str="  hello  "/>
</dirac>
