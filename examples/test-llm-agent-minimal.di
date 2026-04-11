<!-- Minimal test of LLM agent -->
<dirac>
  <import src="../lib/llm-agent.di"/>
  
  <output>About to call llm-agent...</output>
  
  <llm-agent task="Say hello" max-iterations="1"/>
  
  <output>Done!</output>
</dirac>
