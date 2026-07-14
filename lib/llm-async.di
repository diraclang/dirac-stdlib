<!-- LLM Async Execution Library -->
<dirac>
  <!-- 
    Base subroutine for async LLM execution with event hooks
    
    Usage:
      <subroutine name="my-async" extends="llm-async">
        <subroutine name="on-turn"/>       - Override to handle each LLM turn
        <subroutine name="on-complete"/>   - Override to handle completion
        <subroutine name="on-error"/>      - Override to handle errors
        <subroutine name="build-prompt"/>  - Override to customize prompt building
      </subroutine>
    
    State stored in __llm_state__ variable:
      {
        "status": "idle|running|completed|error",
        "turn_count": 0,
        "stop_requested": false,
        "error_message": ""
      }
  -->
  <subroutine name="llm-async">
    <!-- Initialize state -->
    <eval>
      // getVariable and setVariable are available in eval context
      
      // Initialize LLM state if not exists
      let state = getVariable('__llm_state__');
      if (!state) {
        state = JSON.stringify({
          status: 'idle',
          turn_count: 0,
          stop_requested: false,
          error_message: ''
        });
        setVariable('__llm_state__', state, true);
      }
      
      // Initialize dialog if not exists
      let dialog = getVariable('__llm_dialog__');
      if (!dialog) {
        setVariable('__llm_dialog__', JSON.stringify([]), true);
      }
      
      // Parse state
      const stateObj = JSON.parse(state);
      stateObj.status = 'running';
      stateObj.turn_count = 0;
      stateObj.stop_requested = false;
      stateObj.error_message = '';
      setVariable('__llm_state__', JSON.stringify(stateObj), true);
    </eval>
    
    <!-- Main execution loop -->
    <loop count="1000">
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        
        // Check if stop requested and set break flag
        if (state.stop_requested) {
          setVariable('_should_break', 'true', false);
        } else {
          setVariable('_should_break', 'false', false);
        }
      </eval>
      
      <test-if test="$_should_break" eq="true">
        <break/>
      </test-if>
      
      <!-- Increment turn counter -->
      <eval>
        const state = JSON.parse(getVariable('__llm_state__'));
        state.turn_count++;
        setVariable('__llm_state__', JSON.stringify(state), true);
      </eval>
      
      <!-- Build prompt (virtual - can be overridden) -->
      <build-prompt/>
      
      <!-- Execute LLM call -->
      <try>
        <llm noextra="true" output="_llm_response"><variable name="_current_prompt"/></llm>
        
        <!-- Call on-turn hook (virtual - can be overridden) -->
        <on-turn/>
        
        <catch>
          <!-- Handle error -->
          <eval>
            const state = JSON.parse(getVariable('__llm_state__'));
            state.status = 'error';
            state.error_message = getVariable('_error') || 'Unknown error';
            setVariable('__llm_state__', JSON.stringify(state), true);
            setVariable('_should_break', 'true', false);
          </eval>
          
          <!-- Call on-error hook (virtual - can be overridden) -->
          <on-error/>
        </catch>
      </try>
    </loop>
    
    <!-- Mark as completed -->
    <eval>
      
      const state = JSON.parse(getVariable('__llm_state__'));
      if (state.status === 'running') {
        state.status = 'completed';
      }
      setVariable('__llm_state__', JSON.stringify(state), true);
    </eval>
    
    <!-- Call on-complete hook (virtual - can be overridden) -->
    <on-complete/>
    
    <!-- Virtual subroutines (default implementations) -->
    
    <!-- Default: build simple prompt from dialog history -->
    <subroutine name="build-prompt">
      <eval>
        
        const dialog = JSON.parse(getVariable('__llm_dialog__') || '[]');
        
        // Simple default: join all messages
        const prompt = dialog.map(msg => {
          if (msg.role === 'user') return `User: ${msg.content}`;
          if (msg.role === 'assistant') return `Assistant: ${msg.content}`;
          if (msg.role === 'system') return `System: ${msg.content}`;
          return msg.content;
        }).join('\n\n');
        
        setVariable('_current_prompt', prompt || 'Hello', true);  // Set as global
      </eval>
    </subroutine>
    
    <!-- Default: do nothing on turn -->
    <subroutine name="on-turn">
      <eval>
        // Default behavior: just continue
      </eval>
    </subroutine>
    
    <!-- Default: do nothing on complete -->
    <subroutine name="on-complete">
      <eval>
        // Default behavior: do nothing
        return '';
      </eval>
    </subroutine>
    
    <!-- Default: log error -->
    <subroutine name="on-error">
      <eval>
        
        const state = JSON.parse(getVariable('__llm_state__'));
        console.error('LLM Error:', state.error_message);
      </eval>
    </subroutine>
  </subroutine>
  
  <!-- Helper: Request stop -->
  <subroutine name="llm-stop">
    <eval>
      const state = JSON.parse(getVariable('__llm_state__'));
      state.stop_requested = true;
      setVariable('__llm_state__', JSON.stringify(state), true);
    </eval>
  </subroutine>
  
  <!-- Helper: Get current state -->
  <subroutine name="llm-get-state">
    <eval>
      const caller = getParams();
      const outputVar = caller.attributes.name || 'output';
      const state = getVariable('__llm_state__') || '{}';
      setVariable(outputVar, state, false);
      return state;
    </eval>
  </subroutine>
  
  <!-- Helper: Add message to dialog -->
  <subroutine name="llm-add-message">
    <eval>
      const caller = getParams();
      const role = caller.attributes.role || 'user';
      const content = caller.attributes.content || '';
      
      let dialog = JSON.parse(getVariable('__llm_dialog__') || '[]');
      dialog.push({ role, content });
      setVariable('__llm_dialog__', JSON.stringify(dialog), true);
    </eval>
  </subroutine>
</dirac>
