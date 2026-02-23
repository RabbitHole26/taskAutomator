# * Use Bash to interpret and execute this script
#!/bin/bash

# * Source the external functions file
source "$(dirname "${BASH_SOURCE[0]}")/../general-functions.sh"

echo
echo "########## DEPLOYING daisyUi ##########"
echo

# Install daisyUi
echo
echo "Installing daisyUi"
echo
npm i daisyui@latest
echo

# Check if the file "./src/index.css" exists
if file_exists "./src/index.css"; then

	# Clear index.css before appending directives
	# > ./src/index.css

	# Append daisyUi directives at the end of the file
	echo '@plugin "daisyui";' >> ./src/index.css

	echo
	echo "Appended daisyUi directives to ./src/index.css"
  echo
else
	echo
	echo "Error: ./src/index.css not found"
	echo
fi

if file_exists "./index.html"; then

	# Add the "data-theme" attribute to the "html" tag (apply daisyUi light theme by default)
	# sed -i 's/<html lang="en">/<html lang="en" data-theme="dark">/' index.html
	sed -i.bak 's/<html lang="en">/<html lang="en" data-theme="dark">/' index.html && rm index.html.bak
	echo
	echo "Added 'data-theme' attribute to the 'html' tag in 'index.html'."
	echo
else
	echo
	echo "Error: ./index.html not found"
	echo
fi

echo
echo -e "\e[33m daisyUI DEPLOYED\e[0m"
echo
