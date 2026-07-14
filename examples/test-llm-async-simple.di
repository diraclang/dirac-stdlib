<!-- Test LLM Async Structure (No actual LLM calls) -->
<dirac>
  <import src="../lib/llm-async.di"/>
  
  <echo>========================================</echo>
  <echo>Testing LLM Async Structure</echo>
  <echo>========================================</echo>
  
  <!-- Test 1: Basic state initialization -->
  <echo></echo>
  <echo>Test 1: State initialization</echo>
  <echo>------------------------------------</echo>
  
  <eval>
    // Initialize state manually
    setVariable('__llm_state__', JSON.stringify({
      status: 'idle',
      turn_count: 0,
      stop_requested: false,
      error_message: ''
    }), true);
    
    setVariable('__llm_dialog__', JSON.stringify([
      { role: 'user', content: 'Hello' }
    ]), true);
  </eval>
  
  <eval>
    const state = JSON.parse(getVariable('__llm_state__'));
    const dialog = JSON.parse(getVariable('__llm_dialog__'));
    console.log('Initial state:', JSON.stringify(state, null, 2));
    console.log('Initial dialog length:', dialog.length);
  </eval>
  
  <!-- Test 2: Helper functions -->
  <echo></echo>
  <echo>Test 2: Testing helper functions</echo>
  <echo>------------------------------------</echo>
  
  <llm-add-message role="user" content="Test message"/>
  <llm-add-message role="assistant" content="Test response"/>
  
  <eval>
    const dialog = JSON.parse(getVariable('__llm_dialog__'));
    console.log('Dialog after adding messages:', dialog.length, 'messages');
    dialog.forEach((msg, i) => console.log(`  ${i}: ${msg.role} - ${msg.content}`));
  </eval>
  
  <!-- Test 3: Stop mechanism -->
  <echo></echo>
  <echo>Test 3: Testing stop mechanism</echo>
  <echo>------------------------------------</echo>
  
  <llm-stop/>
  
  <eval>
    const state = JSON.parse(getVariable('__llm_state__'));
    console.log('Stop requested:', JSON.stringify(state, null, 2));
  </eval>
  
  <!-- Test 4: Override pattern -->
  <echo></echo>
  <echo>Test 4: Testing override pattern</echo>
  <echo>------------------------------------</echo>
  
  <llm-async>
    <build-prompt>
      <eval>
        console.log('[Override] build-prompt called');
        setVariable('_current_prompt', 'Custom prompt', false);
      </eval>
    </build-prompt>
    
    <on-turn>
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        console.log('[Override] on-turn called, turn:', state.turn_count);
        
        // Stop after 2 turns
        if (state.turn_count >= 2) {
          console.log('[Override] Stopping after 2 turns');
          const newState = JSON.parse(getVariable('__llm_state__'));
          newState.stop_requested = true;
          setVariable('__llm_state__', JSON.stringify(newState), true);
        }
      </eval>
    </on-turn>
    
    <on-complete>
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        console.log('[Override] on-complete called');
        console.log('[Override] Final state:', state);
      </eval>
    </on-complete>
  </llm-async>
  
  <echo></echo>
  <echo>All structure tests completed!</echo>
</dirac>
