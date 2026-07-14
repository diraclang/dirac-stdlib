<dirac>
  <defvar name="test_prompt" value="Hello, please say 'test successful' in response."/>
  
  <echo>Testing basic LLM call...</echo>
  <llm noextra="true" output="llm_result">$test_prompt</llm>
  
  <echo>LLM Response: $llm_result</echo>
</dirac>
