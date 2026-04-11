<!-- Test LLM execute mode directly -->
<dirac>
  <output>Testing LLM execute mode with hardcoded prompt...</output>
  
  <llm execute="true" feedback="true" max-iterations="2" noextra="true">You are a helpful assistant. Say "Hello" and then use an output tag like this: &lt;output&gt;World!&lt;/output&gt;

If you want to continue, include another &lt;llm&gt; tag in your response.</llm>
  
  <output>
Test complete!</output>
</dirac>
