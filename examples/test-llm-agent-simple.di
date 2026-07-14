<!-- Test simple LLM agent -->
<dirac>
  <import src="dirac-stdlib/lib/llm-agent-simple.di"/>
  <import src="dirac/lib/native-tags.di"/>

  <output>
=== Testing LLM-driven recursive execution ===
The LLM should output 3 steps and use &lt;llm&gt; tags to continue.
</output>
  
  <llm-agent max_iterations="3">You are executing in the Dirac language environment.

TASK: Output exactly 3 steps, numbered 1, 2, and 3.

CRITICAL: You must use the &lt;llm&gt; tag (NOT &lt;llm-agent&gt;) to continue recursively.

INSTRUCTIONS:
1. First, output: &lt;output&gt;Step 1 complete&lt;/output&gt;
2. Then include: &lt;llm&gt;Continue to step 2&lt;/llm&gt;  (Use &lt;llm&gt; NOT &lt;llm-agent&gt;)
3. When you receive "Continue to step 2", output: &lt;output&gt;Step 2 complete&lt;/output&gt;
4. Then include: &lt;llm&gt;Continue to step 3&lt;/llm&gt;  (Use &lt;llm&gt; NOT &lt;llm-agent&gt;)
5. When you receive "Continue to step 3", output: &lt;output&gt;Step 3 complete&lt;/output&gt;
6. After step 3, DO NOT include another &lt;llm&gt; tag (this ends the recursion)

IMPORTANT: Only respond with the exact Dirac XML tags shown above. Use &lt;llm&gt; for recursion.

Start with step 1 now:</llm-agent>
  
  <output>
=== Test Complete ===
If you saw "Step 1 complete", "Step 2 complete", and "Step 3 complete", then LLM-driven recursion worked!
</output>

  <output>

=== LLM Dialog History ===
This shows the complete conversation flow between Dirac and the LLM:
</output>
  
  <eval>
    const dialog = getVariable('__llm_dialog__');
    if (dialog) {
      const messages = JSON.parse(dialog);
      let output = '';
      messages.forEach((msg, i) => {
        output += `\n\n--- Message ${i + 1} (${msg.role}) ---\n${msg.content}\n`;
      });
      setVariable('_dialog_output', output, true);
    } else {
      setVariable('_dialog_output', '\nNo dialog history found\n', true);
    }
  </eval>
  
  <output><variable name="_dialog_output"/></output>
  
  <output>

=== End Dialog History ===
</output>
</dirac>
