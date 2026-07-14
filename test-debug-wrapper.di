|import src="./lib/bash-commands.di" >

Testing echo with debug:
<defvar name="test_msg" value="Hello World" />
<defvar name="cmd" value="echo" />
Before assign: <variable name="cmd" />
<assign name="cmd"><variable name="cmd" /> <variable name="test_msg" /></assign>
After assign: <variable name="cmd" />
<system><variable name="cmd" /></system>

Now testing the wrapper:
<echo message="Hello from wrapper!" />

Done!
