<!-- Test variable substitution in max-iterations -->
<dirac>
  <eval>
    setVariable('my_max', '2', true);
  </eval>
  
  <output>Testing with max-iterations=$my_max</output>
  
  <llm execute="true" feedback="true" max-iterations="$my_max" noextra="true">Say "Hello" then output &lt;output&gt;Step 1&lt;/output&gt; then use &lt;llm&gt;Continue&lt;/llm&gt; to trigger next iteration</llm>
  
  <output>
Done!</output>
</dirac>
