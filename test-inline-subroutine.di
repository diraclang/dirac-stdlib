<subroutine name="test-echo"
  description="Test echo wrapper"
  param-message="string:required:Message to echo"
  meta-bash-command="echo">

  <defvar name="cmd" value="echo" />
  <assign name="cmd" value="${cmd} ${message}" />
  
  DEBUG - Command will be: <variable name="cmd" />
  
  <system><variable name="cmd" /></system>
</subroutine>

Testing:
<test-echo message="Hello World" />

Done!
