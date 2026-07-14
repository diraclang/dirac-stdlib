<!-- LLM Agent Library - LLM-driven recursive execution with event hooks -->
<dirac>
  <!-- 
    LLM Agent with virtual subroutine hooks for customization
    
    Usage:
      <subroutine name="my-agent" extends="llm-agent">
        <subroutine name="build-prompt"/>   - Customize initial prompt
        <subroutine name="on-complete"/>    - Called when agent finishes
      </subroutine>
      
      <my-agent task="Analyze the system"/>
    
    How it works:
    - Builds prompt via build-prompt virtual subroutine
    - Calls <llm execute="true" feedback="true">
    - LLM response is executed as Dirac code
    - If LLM includes <llm> tags in response, they execute recursively
    - LLM controls the flow, not Dirac loop
    - Continues until LLM stops requesting more calls or max iterations reached
  -->
  <subroutine name="llm-agent">
    <!-- Build initial prompt using virtual subroutine -->
    <build-prompt/>
    
    <!-- Execute LLM with recursive execution enabled -->
    <eval>
      const prompt = getVariable('_agent_prompt');
      const maxIter = getVariable('_agent_max_iterations');
      
      // Store for LLM call
      setVariable('__final_prompt', prompt, true);
      setVariable('__final_max_iter', maxIter, true);
    </eval>
    
    <llm execute="true" feedback="true" max-iterations="$__final_max_iter" noextra="true"><variable name="__final_prompt"/></llm>
    
    <!-- Call completion hook -->
    <on-complete/>
    
    <!-- Virtual subroutines (default implementations) -->
    
    <!-- Default: build simple prompt from task -->
    <subroutine name="build-prompt">
      <eval>
        // Get the caller (the llm-agent call or extended subroutine call)
        const params = getParams();
        
        console.log('DEBUG build-prompt - params:', JSON.stringify({
          tag: params.tag,
          attributes: params.attributes,
          parent: params.parent ? { tag: params.parent.tag, attributes: params.parent.attributes } : null
        }));
        
        // Walk up to find the actual caller
        let caller = params;
        while (caller && caller.parent && caller.parent.tag !== 'dirac') {
          console.log('DEBUG walking:', caller.parent.tag, caller.parent.attributes);
          if (caller.parent.attributes && caller.parent.attributes.task) {
            caller = caller.parent;
            break;
          }
          caller = caller.parent;
        }
        
        console.log('DEBUG final caller:', caller ? { tag: caller.tag, attributes: caller.attributes } : null);
        
        const task = (caller && caller.attributes && caller.attributes.task) || 'Help me';
        const maxIter = (caller && caller.attributes && caller.attributes['max-iterations']) || '10';
        
        console.log('DEBUG task:', task, 'maxIter:', maxIter);
        
        const prompt = `You are a helpful AI agent executing in the Dirac language environment.

Task: ${task}

Instructions:
- You can execute Dirac code by including it in your response
- If you need more information or want to perform actions, include <llm> tags in your response to continue
- When you're done, provide your final answer without any <llm> tags
- You have up to ${maxIter} iterations to complete the task

Available Dirac tags you can use in your response:
- <output>text</output> - Display text
- <eval>JavaScript code</eval> - Execute JavaScript
- <llm>prompt</llm> - Make another LLM call (recursive)
- Any custom subroutines defined in the system`;
        
        console.log('DEBUG prompt length:', prompt.length);
        
        setVariable('_agent_prompt', prompt, true);
        setVariable('_agent_max_iterations', maxIter, true);
      </eval>
    </subroutine>
    
    <!-- Default: do nothing on complete -->
    <subroutine name="on-complete">
      <eval>
        // Default: do nothing
      </eval>
    </subroutine>
  </subroutine>
</dirac>
