<!-- LLM Agent - Simple wrapper around execute mode -->
<dirac>
  <!-- 
    LLM Agent: Executes LLM in recursive mode where LLM controls the flow
    
    Usage:
      <llm-agent max-iterations="5">Your task prompt here</llm-agent>
    
    Or with variable:
      <eval>setVariable('my_prompt', 'Do something', true);</eval>
      <llm-agent max-iterations="5"><variable name="my_prompt"/></llm-agent>
    
    How it works:
    - Wraps <llm execute="true" feedback="true">
    - LLM response is executed as Dirac code
    - If LLM includes <llm> tags in response, they execute recursively
    - LLM controls the flow until it stops or reaches max iterations
  -->
  <subroutine name="llm-agent" param-max_iterations="string|required||" >
    <defvar name="_agent_prompt_text" />
    <defvar name="_agent_max_iter" />
    <eval>
      const caller = getParams();
      const maxIter = caller.attributes['max_iterations'] || '10';
      setVariable('_agent_max_iter', maxIter, true);
      
      // Get text content from the caller
      let promptText = '';
      if (caller.children && caller.children.length > 0) {
        // Collect text from children
        for (const child of caller.children) {
          if (typeof child === 'string') {
            promptText += child;
          } else if (child.tag === '#text' || child.tag === 'text') {
            promptText += child.text || '';
          } else if (child.text) {
            promptText += child.text;
          }
        }
      }
      
      const trimmedPrompt = promptText.trim();
      console.log('LLM Agent: Prompt length =', trimmedPrompt.length);
      console.log('LLM Agent: Max iterations =', maxIter);
      
      setVariable('_agent_prompt_text', trimmedPrompt, true);
      setVariable('_agent_max_iter', maxIter, true);
    </eval>
    
    <!-- Remove noextra so LLM knows about available tags including <llm> for recursion -->
    <!-- Add save-dialog to preserve the conversation history -->
    <llm execute="true" feedback="true" max-iterations="$_agent_max_iter" save-dialog="true"><parameters select="*" /></llm>
  </subroutine>
</dirac>
