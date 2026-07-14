<!-- Test LLM with on-iteration callback for monitoring -->
<dirac>
  <import src="dirac/lib/native-tags.di"/>
  
  <!-- Define callback subroutine to monitor each iteration -->
  <subroutine name="my-callback">
    <output>

========================================
ITERATION <variable name="__llm_iteration__"/> of <variable name="__llm_max_iterations__"/>
========================================
Dialog so far:
</output>
    
    <eval>
      const dialog = getVariable('__llm_dialog__');
      if (dialog) {
        const messages = JSON.parse(dialog);
        let output = '';
        messages.forEach((msg, i) => {
          output += `\n--- Message ${i + 1} (${msg.role}) ---\n${msg.content.substring(0, 200)}${msg.content.length > 200 ? '...' : ''}\n`;
        });
        setVariable('_dialog_summary', output, true);
      } else {
        setVariable('_dialog_summary', '\nNo dialog yet\n', true);
      }
    </eval>
    
    <output><variable name="_dialog_summary"/>
========================================
</output>
  </subroutine>
  
  <output>Starting LLM with on-iteration monitoring...</output>
  
  <llm execute="true" feedback="true" max-iterations="3" save-dialog="true" on-iteration="my-callback">You are a helpful assistant.

Task: Count from 1 to 3 using <output> tags.

Instructions:
1. Output: <output>Count: 1</output>
2. Then use: <llm>Continue to 2</llm>
3. When you get "Continue to 2", output: <output>Count: 2</output>
4. Then use: <llm>Continue to 3</llm>
5. When you get "Continue to 3", output: <output>Count: 3</output>
6. After 3, just respond "DONE" (no more <llm> tags)

Start now.</llm>
  
  <output>

=== Test Complete ===</output>
</dirac>
