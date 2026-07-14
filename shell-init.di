# Default Dirac Shell Initialization
# This script runs automatically when the shell starts

# Load essential subroutines from stdlib
|import src="lib/ai.di">
|import src="lib/native-tags.di">

# Auto-index user's saved subroutines for search functionality
<index-subroutines path="~/.dirac/lib/user" />

# Welcome message (optional - uncomment to enable)
# |output>Welcome to Dirac! Type :help for available commands.
