<dirac>
  <defvar name="_current_prompt" value="Say hello"/>
  
  <echo>Prompt: <variable name="_current_prompt"/></echo>
  
  <echo>Calling LLM...</echo>
  <llm noextra="true" output="_llm_response"><variable name="_current_prompt"/></llm>
  
  <echo>Response: <variable name="_llm_response"/></echo>
</dirac>
