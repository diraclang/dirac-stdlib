|import src="./lib/bash-commands.di" >

Testing DIRAC bash command wrappers...

=== Testing echo ===
|echo message="Hello from DIRAC wrapper!" >

=== Testing ls (current directory) ===
|ls path="." >

=== Testing ls with flags ===
|ls path="." all="true" long="true" >

=== Testing mkdir ===
|mkdir path="/tmp/dirac-test-dir" parents="true" >

=== Verify directory created ===
|ls path="/tmp" long="true" >

=== Testing rm ===
|rm path="/tmp/dirac-test-dir" >

Done!
