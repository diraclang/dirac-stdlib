<!-- TEST: string_split_basic -->
<!-- EXPECT: hello
world
test -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="SPLIT" str="hello,world,test" delimiter=","/>
</dirac>
