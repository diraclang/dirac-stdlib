<!-- Test accessing attributes in nested subroutine -->
<dirac>
  <subroutine name="test-parent">
    <subroutine name="test-nested">
      <eval>
        const params = getParams();
        console.log('Nested - params tag:', params.tag);
        console.log('Nested - params.attributes:', params.attributes);
        
        if (params.parent) {
          console.log('Nested - parent tag:', params.parent.tag);
          console.log('Nested - parent.attributes:', params.parent.attributes);
        }
        
        // Walk up the tree
        let current = params;
        let depth = 0;
        while (current && depth < 10) {
          console.log(`Level ${depth}: tag=${current.tag}, attrs=`, current.attributes);
          current = current.parent;
          depth++;
        }
      </eval>
    </subroutine>
    
    <test-nested/>
  </subroutine>
  
  <test-parent task="mytask" max-iterations="5"/>
</dirac>
