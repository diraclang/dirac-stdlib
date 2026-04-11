<!-- Test LLM Agent with custom prompt and completion hook -->
<dirac>
  <import src="../lib/llm-agent.di"/>
  
  <!-- Custom agent that extends llm-agent -->
  <subroutine name="my-research-agent" extends="llm-agent">
    
    <!-- Override build-prompt to customize the initial prompt -->
    <subroutine name="build-prompt">
      <eval>
        const caller = getParams();
        const task = caller.parent.attributes.task || 'Research a topic';
        const maxIter = caller.parent.attributes['max-iterations'] || '5';
        
        const prompt = `You are a research assistant helping with: ${task}

IMPORTANT INSTRUCTIONS:
- You can execute Dirac code by wrapping it in your response
- To continue researching or ask for more data, include <llm>your next question</llm> in your response
- The <llm> tag will execute recursively, allowing you to make multiple calls
- When you have enough information, provide your final answer WITHOUT any <llm> tags
- You have up to ${maxIter} iterations

Example of continuing research:
<output>Found initial data about topic X</output>
<llm>Now I need more details about aspect Y of topic X</llm>

Example of finishing:
<output>Based on my research, here are my findings: ...</output>

Please start your research now.`;
        
        setVariable('_agent_prompt', prompt, true);
        setVariable('_agent_max_iterations', maxIter, true);
      </eval>
    </subroutine>
    
    <!-- Override on-complete to show summary -->
    <subroutine name="on-complete">
      <output>

=== Research Agent Complete ===
Thank you for using the research agent!
===========================
</output>
    </subroutine>
    
  </subroutine>
  
  <!-- Execute the research agent -->
  <output>Starting LLM-driven research agent...
The agent will recursively call itself as needed (LLM controls the flow).
</output>
  
  <my-research-agent 
    task="Explain how the Dirac language execute attribute works in the llm tag" 
    max-iterations="3"/>
  
</dirac>
