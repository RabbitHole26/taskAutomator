# #######################################################################################
# Use Bash to interpret and execute this script
# #######################################################################################

#!/bin/bash

# #######################################################################################
# SET UP SCRIPT DIRECTORY
# #######################################################################################

# * Determine the absolute path to the script directory using pwd
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# #######################################################################################
# SOURCE GENERAL FUNCTIONS FROM SEPARATE SCRIPT
# #######################################################################################

# * take advantage of previously defined SCRIPT_DIR to source external functions file
source "$SCRIPT_DIR/general-functions.sh"

# #######################################################################################
# INTRO
# #######################################################################################

echo
echo
echo  "     ###########################################################"
echo -e "     ##             \e[35mVITE + REACT + DEPENDENCIES\e[0m               ##"
echo -e "     ##                 \e[31mInstallation script\e[0m                   ##"
echo  "     ###########################################################"
echo	
echo

# #######################################################################################
# VARIABLES
# #######################################################################################

invalid_input_message="Invalid input. Please enter Y to continue or N to abort."
deployment_script_dir="$SCRIPT_DIR/vite-react-deployment-scripts"

# #######################################################################################
# SCAFFOLD PROJECT
# #######################################################################################

echo
echo "########## SCAFFOLDING THE PROJECT ##########"
echo

# * Create vite->react->js-swc project in the current folder
npm create vite@latest . -- --template react-swc

while true; do
  # * Ask the user if they want to continue. Allow the user to exit script if Vite scaffolding fails or is aborted
	read -p $'\e[1;35mWould you like to continue? (Y/N): \e[0m' choice

	# * Convert the input to uppercase for case-insensitive comparison
	choice=$(convert_to_uppercase "$choice")

	# * Check if the input is valid
	if [ "$choice" = "Y" ]; then
		# Exit the loop if the input is valid
		break  
	elif [ "$choice" = "N" ]; then
		echo
		echo "Aborting the script"
		echo
		# Exit the script with a non-zero status (indicate failure)
		exit 1
	else
		echo
		echo "$invalid_input_message"
		echo
	fi
done

# * Install NPM
echo
echo "Installing NPM"
echo
npm install
echo
echo
echo -e "\e[33m PROJECT SCAFFOLDED\e[0m"
echo

# ! deployment scripts
# #######################################################################################
# DEPLOY TAILWIND + daisyUI
# #######################################################################################

"$deployment_script_dir/tailwind-daisyUi.sh"

# #######################################################################################
# STYLED COMPONENTS
# #######################################################################################

"$deployment_script_dir/styled-components.sh"

# #######################################################################################
# REACT-ROUTER-DOM
# #######################################################################################

"$deployment_script_dir/react-router-dom.sh"

# #######################################################################################
# REACT SPINNERS
# #######################################################################################

"$deployment_script_dir/react-spinners.sh"

# #######################################################################################
# FONT AWESOME
# #######################################################################################

"$deployment_script_dir/font-awesome.sh"

# #######################################################################################
# CLASSNAMES
# #######################################################################################

"$deployment_script_dir/class-names.sh"

# #######################################################################################
# REACT-HOT-TOAST
# #######################################################################################

"$deployment_script_dir/react-hot-toast.sh"

# #######################################################################################
# HEADLESSUI
# #######################################################################################

"$deployment_script_dir/headless-ui.sh"
# ! end of deployment scripts

# #######################################################################################
# FINISHING TOUCHES
# #######################################################################################

echo
echo "########## FINISHING TOUCHES ##########"
echo

# * Create .env file in the current directory
touch .env
echo
echo "Created .env"

while true; do
  # * Check how to modify the .env file
	echo
	read -p $'\e[1;35mUse Chrome as default browser to run the project locally? (Y/N): \e[0m' choice

	# * Convert the input to uppercase for case-insensitive comparison
	choice=$(convert_to_uppercase "$choice")

	if [ "$choice" = "Y" ]; then
		while true; do
			echo
			read -p $'\e[1;35mWindows + WSL (Y) or Ubuntu (N)? (Y/N): \e[0m' choice
			choice=$(convert_to_uppercase "$choice")
			# * Set BROWSER variable to Chrome in the .env file
			if [ "$choice" = "Y" ]; then
				echo 'BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"' >> .env
				echo
				echo "Set the browser to 'google-chrome' in .env"
				break
			elif [ "$choice" = "N" ]; then
				echo "BROWSER=google-chrome" >> .env
				echo
				echo "Set the browser to 'google-chrome' in .env"
				break
			else
				echo
				echo "$invalid_input_message"
				echo
			fi
		done
		break
	# terminate the loop
	elif [ "$choice" = "N" ]; then
		break
	else
		echo
		echo "$invalid_input_message"
		echo
	fi
done

# Add .env file to .gitignore
echo >> .gitignore
echo "# Exclude .env file from the remote repo" >> .gitignore
echo ".env" >> .gitignore
echo
echo "Added .env to .gitignore"

# * Modify the "dev" script in package.json to include .env variables
# Check if package.json exists
if [ -f "package.json" ]; then
	# Use sed to modify the "dev" script in package.json
	sed -i 's/"dev": "vite",/"dev": "vite --open $BROWSER",/' package.json
	echo
	echo "Modified 'dev' script in package.json"
else
	echo
	echo "Error: package.json not found"
fi

# * Modify the "rules" script in ./eslint.config.js (disable some of the eslint validations which might be a bit annoying)
if [ -f "./eslint.config.js" ]; then
	# Use sed to modify the './eslint.config.js' file
	sed -i "s|'react/jsx-no-target-blank': 'off',|'react/prop-types': 'off',\n      'react/jsx-no-target-blank': 'off',|" ./eslint.config.js
	# sed -i "s|env: { browser: true, es2020: true },|env: { browser: true, es2020: true, node: true },|" ./eslint.config.js
	echo
	echo "Modified 'rules' in ./eslint.config.js"
else
	echo
	echo "Error: ./eslint.config.js not found"
fi

# * Check if the file "./src/App.jsx" exists to clear its content
if file_exists "./src/App.jsx"; then
	# Clear the content of ./src/App.jsx
	> ./src/App.jsx

# ! this section will modify the app.jsx file to include Tailwind and daisyUi classes
# ! this is to confirm if these were successfully installed, when the project loads the styling should take effect
# ! can be disabled if not using Tailwind
# Update ./src/App.jsx with the provided content
	echo "import './App.css'" >> ./src/App.jsx
echo "" >> ./src/App.jsx
echo "function App() {" >> ./src/App.jsx
echo "  return (" >> ./src/App.jsx
echo "    <>" >> ./src/App.jsx
echo "      <div className='flex flex-col justify-center items-center gap-6 h-screen text-base-content'>" >> ./src/App.jsx
echo "        <h1 className='text-6xl'>HAPPY CODING!</h1>" >> ./src/App.jsx
echo "        <button" >> ./src/App.jsx
echo "          className='btn btn-primary'" >> ./src/App.jsx
echo "          onClick={() => {alert(\"You've just pressed the button. Well done!\")}}" >> ./src/App.jsx
echo "        >" >> ./src/App.jsx
echo "          Test button" >> ./src/App.jsx
echo "        </button>" >> ./src/App.jsx
echo "      </div>" >> ./src/App.jsx
echo "    </>" >> ./src/App.jsx
echo "  )" >> ./src/App.jsx
echo "}" >> ./src/App.jsx
echo "" >> ./src/App.jsx
echo "export default App" >> ./src/App.jsx
echo "" >> ./src/App.jsx
	echo
	echo "Modified ./src/App.jsx"
else
	echo
	echo "Error: ./src/App.jsx not found"
fi

# * Check if the file "./index.html" exists to carry on with specific tasks
if file_exists "./index.html"; then

	# Update ./index.html with the provided content
	sed -i 's/Vite + React/My Project/' index.html
	sed -i 's|<link rel="icon" type="image/svg+xml" href="/vite.svg" />|<link rel="icon" type="" href="" />|' index.html
	echo
	echo "Modified ./index.html"
	echo
else
	echo
	echo "Error: ./index.html not found"
	echo
fi

# * Check if the file "./src/App.css" exists to clear its content
if file_exists "./src/App.css"; then
	# Clear the content of ./src/App.css
	> ./src/App.css
	echo "Cleared ./src/App.css"
	echo
else
	echo "Error: ./src/App.css not found"
	echo
fi

if is_commented "tailwind-daisyUi.sh"; then
  if file_exists "./src/index.css"; then
    > ./src/index.css
    echo "Cleared ./src/index.css"
    echo
  else
    echo "Error: ./src/index.css not found"
    echo
  fi
fi

# * Check if directory "./src/assets" exists to clear its content
if directory_exists "./src/assets"; then
	# Force remove the content of the directory
	rm -rf ./src/assets/*
	echo "Content of ./src/assets removed"
	echo
else
	echo
	echo "Error: ./src/assets not found"
	echo
fi

# * Check if directory "./public" exists to clear its content
if directory_exists "./public"; then
	# force remove the content of the directory
	rm -rf ./public/*
	echo "Content of ./public removed"
	echo
else
	echo "Error: ./public not found"
	echo
fi

echo
echo -e "\e[33m FINISHING TOUCHES COMPLETED\e[0m"
echo

# #######################################################################################
# DISABLE REACT STRICTMODE
# #######################################################################################

echo
while true; do
	read -p $'\e[1;35mWould you like to disable React StrictMode? (Y/N): \e[0m' choice

	choice=$(convert_to_uppercase "$choice")

	# * Check the user's choice to modify content of main.jsx file
	if [ "$choice" = "Y" ]; then
		# Check if file exists
		if file_exists "./src/main.jsx"; then
			# * Modify the content of ./src/main.jsx
			# sed -i -E 's|^import React from '\''react'\''|// &|; s|<React.StrictMode>|//&|; s|</React.StrictMode>,|//&|' ./src/main.jsx
			sed -i -E 's|^import \{ StrictMode \} from '\''react'\''|// &|; s|<StrictMode>|//&|; s|</StrictMode>|//&|' ./src/main.jsx
			echo
			echo "Modified ./src/main.jsx"
			echo
			echo
			echo -e "\e[33m REACT STRICTMODE DISABLED\e[0m"
			echo
			echo
			break
		else
			echo
			echo "Error: ./src/main.jsx not found"
			echo
		fi
	elif [ "$choice" = "N" ]; then
		echo
		break
	else
		echo
		echo "$invalid_input_message"
		echo
	fi
done

# #######################################################################################
# RUN VSCODE
# #######################################################################################

while true; do
	read -p $'\e[1;35mWould you like to run VSCODE? (Y/N): \e[0m' choice

	choice=$(convert_to_uppercase "$choice")

	# * Check the user's choice to run VS code
	if [ "$choice" = "Y" ]; then
		code .
		sleep 2 && npm run dev
		break
	elif [ "$choice" = "N" ]; then
		echo
		echo "Exiting the script"
		echo
		# Exit the script with a non-zero status (indicate failure)
		exit 1
	else
		echo
		echo "$invalid_input_message"
		echo
	fi
done
