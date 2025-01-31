# * Use Bash to interpret and execute this script
#!/bin/bash

# #######################################################################################
# GENERAL FUNCTIONS
# #######################################################################################

# * Check if files to modify exist (0 file exists, 1 file doesn't exist)
file_exists() {
	if [ -f "$1" ]; then
		return 0
	else
		return 1
	fi
	}

# * Check if a directory exists (0 dir exists, 1 dir doesn't exist)
directory_exists() {
	if [ -d "$1" ]; then
		return 0
	else
		return 1
	fi
}

# * Check if a script line is commented out (0 if not commented, 1 if commented)
is_commented() {
  local script_line="$1"
  grep -E "^\s*#.*$script_line" "$0" > /dev/null
  return $?
}

# * Convert user input to uppercase, this will normalize user input when asking Y/N questions
convert_to_uppercase() {
  echo "$1" | tr '[:lower:]' '[:upper:]'
}
