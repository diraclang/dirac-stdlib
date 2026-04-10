<!-- Test LLM Async Execution -->
<dirac>
  <import src="../lib/llm-async.di"/>
  
  <!-- Example: Simple counter that stops after 3 turns -->
  <test-simple-async>
    <echo>Starting simple async test...</echo>
    
    <!-- Initialize dialog with a simple task -->
    <llm-add-message role="user" content="Count from 1 to 10"/>
    
    <!-- Override llm-async to add custom behavior -->
    <llm-async>
      <!-- Override build-prompt to add turn counter -->
      <build-prompt>
        <eval>
          
          const state = JSON.parse(getVariable('__llm_state__'));
          const dialog = JSON.parse(getVariable('__llm_dialog__') || '[]');
          
          const prompt = `You are a helpful assistant. This is turn ${state.turn_count}.
          
${dialog.map(msg => `${msg.role}: ${msg.content}`).join('\n')}

Please respond briefly.`;
          
          setVariable('_current_prompt', prompt, false);
        </eval>
      </build-prompt>
      
      <!-- Override on-turn to add stop logic -->
      <on-turn>
        <eval>
          
          const state = JSON.parse(getVariable('__llm_state__'));
          const response = getVariable('_llm_response') || '';
          
          console.log(`[Turn ${state.turn_count}] Response received`);
          
          // Add response to dialog
          let dialog = JSON.parse(getVariable('__llm_dialog__'));
          dialog.push({ role: 'assistant', content: response });
          setVariable('__llm_dialog__', JSON.stringify(dialog), true);
          
          // Stop after 3 turns
          if (state.turn_count >= 3) {
            console.log('Reached 3 turns, stopping...');
            state.stop_requested = true;
            setVariable('__llm_state__', JSON.stringify(state), true);
          }
          
        </eval>
      </on-turn>
      
      <!-- Override on-complete to show final status -->
      <on-complete>
        <eval>
          
          const state = JSON.parse(getVariable('__llm_state__'));
          const dialog = JSON.parse(getVariable('__llm_dialog__'));
          
          console.log('\n=== Async Execution Completed ===');
          console.log(`Status: ${state.status}`);
          console.log(`Total turns: ${state.turn_count}`);
          console.log(`Dialog length: ${dialog.length} messages`);
          console.log('================================\n');
        </eval>
      </on-complete>
      
      <!-- Override on-error to handle errors -->
      <on-error>
        <eval>
          
          const state = JSON.parse(getVariable('__llm_state__'));
          
          console.error('\n=== Error Occurred ===');
          console.error(`Error: ${state.error_message}`);
          console.error(`Turn: ${state.turn_count}`);
          console.error('====================\n');
        </eval>
      </on-error>
    </llm-async>
    
    <echo>Async test completed!</echo>
  </test-simple-async>
  
  <!-- Example: Monitoring agent that processes updates -->
  <test-monitoring-async>
    <echo>Starting monitoring test...</echo>
    
    <!-- Simulate monitoring data -->
    <defvar name="monitoring_data" value='[{"metric": "cpu", "value": 45}, {"metric": "memory", "value": 78}]'/>
    
    <llm-async>
      <!-- Override build-prompt to include monitoring data -->
      <build-prompt>
        <eval>
          
          const state = JSON.parse(getVariable('__llm_state__'));
          const monitoringData = getVariable('monitoring_data');
          
          const prompt = `You are a monitoring agent. Analyze this data and provide insights.

Turn: ${state.turn_count}
Data: ${monitoringData}

Provide a brief analysis.`;
          
          setVariable('_current_prompt', prompt, false);
        </eval>
      </build-prompt>
      
      <!-- Override on-turn to process monitoring updates -->
      <on-turn>
        <eval>
          
          const state = JSON.parse(getVariable('__llm_state__'));
          const response = getVariable('_llm_response') || '';
          
          console.log(`[Monitoring Turn ${state.turn_count}]`);
          console.log(`Analysis: ${response.substring(0, 100)}...`);
          
          // Stop after 2 turns for demo
          if (state.turn_count >= 2) {
            console.log('Monitoring demo complete');
            state.stop_requested = true;
            setVariable('__llm_state__', JSON.stringify(state), true);
          }
          
        </eval>
      </on-turn>
      
      <!-- Override on-complete -->
      <on-complete>
        <eval>
          
          const state = JSON.parse(getVariable('__llm_state__'));
          
          console.log(`\nMonitoring completed after ${state.turn_count} turns`);
        </eval>
      </on-complete>
    </llm-async>
    
    <echo>Monitoring test completed!</echo>
  </test-monitoring-async>
  
  <!-- Run tests -->
  <echo>========================================</echo>
  <echo>Testing LLM Async Execution</echo>
  <echo>========================================</echo>
  
  <echo></echo>
  <echo>Test 1: Simple counter with 3 turns</echo>
  <echo>------------------------------------</echo>
  <test-simple-async/>
  
  <echo></echo>
  <echo>Test 2: Monitoring agent with 2 turns</echo>
  <echo>------------------------------------</echo>
  <test-monitoring-async/>
  
  <echo></echo>
  <echo>All tests completed!</echo>
</dirac>
