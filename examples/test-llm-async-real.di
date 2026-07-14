<!-- Test LLM Async with Real LLM Calls -->
<dirac>
  <import src="../lib/llm-async.di"/>
  
  <output>========================================</output>
  <output>Testing LLM Async with Real LLM</output>
  <output>========================================</output>
  
  <!-- Define custom async LLM with overrides -->
  <subroutine name="my-llm-async" extends="llm-async">
    <!-- Override build-prompt -->
    <subroutine name="build-prompt">
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        
        const prompt = `You are a helpful assistant. This is turn ${state.turn_count}.
Please respond with just the number ${state.turn_count} and a brief greeting (max 10 words).`;
        
        setVariable('_current_prompt', prompt, true);  // Set as global!
      </eval>
    </subroutine>
    
    <!-- Override on-turn -->
    <subroutine name="on-turn">
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        const response = getVariable('_llm_response') || '';
        
        console.log(`\n[Turn ${state.turn_count}]`);
        console.log(`Response: ${response}`);
        
        // Stop after 3 turns
        if (state.turn_count >= 3) {
          console.log('\n✓ Reached 3 turns, stopping...');
          const newState = JSON.parse(getVariable('__llm_state__'));
          newState.stop_requested = true;
          setVariable('__llm_state__', JSON.stringify(newState), true);
        }
      </eval>
    </subroutine>
    
    <!-- Override on-complete -->
    <subroutine name="on-complete">
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        
        console.log('\n=== Async Execution Completed ===');
        console.log(`Status: ${state.status}`);
        console.log(`Total turns: ${state.turn_count}`);
        console.log('================================\n');
      </eval>
    </subroutine>
    
    <!-- Override on-error -->
    <subroutine name="on-error">
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        const error = getVariable('_error') || 'No error variable set';
        
        console.error('\n=== Error Occurred ===');
        console.error(`Error: ${state.error_message}`);
        console.error(`Error variable: ${error}`);
        console.error(`Turn: ${state.turn_count}`);
        console.error('====================\n');
      </eval>
    </subroutine>
  </subroutine>
  
  <!-- Example: Counter that asks LLM 3 times -->
  <output></output>
  <output>Test: 3-turn conversation</output>
  <output>------------------------------------</output>
  
  <!-- Call the extended subroutine -->
  <output>About to call my-llm-async...</output>
  <my-llm-async/>
  <output>Finished calling my-llm-async</output>
  
  <output></output>
  <output>Test completed!</output>
</dirac>
