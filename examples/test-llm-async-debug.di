<dirac>
  <import src="../lib/llm-async.di"/>
  
  <output>Before calling llm-async...</output>
  
  <!-- Try to call the base subroutine directly -->
  <eval>
    console.log('Available subroutines:', session.subroutines.map(s => s.name));
  </eval>
  
  <llm-async/>
  
  <output>After calling llm-async</output>
</dirac>
