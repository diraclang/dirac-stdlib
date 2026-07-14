<!-- Test LLM response WITHOUT execute to see what it returns -->
<dirac>
  <output>Testing LLM without execute mode...</output>
  
  <eval>
    console.log('About to call LLM...');
  </eval>
  
  <llm noextra="true" output="llm_response">You are a helpful assistant.

Task: Count from 1 to 3, using <output> tags for each number.

Instructions:
- For each number, use: &lt;output&gt;Number: X&lt;/output&gt;
- After each output, use &lt;llm&gt; to continue to the next number
- After outputting 3, stop (don't include another &lt;llm&gt; tag)

Start now!</llm>
  
  <eval>
    console.log('After LLM call');
    const response = getVariable('llm_response');
    console.log('Response variable:', response);
    console.log('Response length:', response ? response.length : 'null');
  </eval>
  
  <output>
=== LLM Response ===
<variable name="llm_response"/>
=== End Response ===
</output>
</dirac>
