<!-- TEST: string_join_basic -->
<!-- EXPECT: hello,world,test -->
<dirac>
  <import src="../lib/string.di"/>
  <call name="JOIN" items="hello
world
test" delimiter=","/>
</dirac>
