# * Use Bash to interpret and execute this script
#!/bin/bash

# * Source the external functions file
source "$(dirname "${BASH_SOURCE[0]}")/../general-functions.sh"

echo
echo "########## DEPLOYING TAILWIND + daisyUI ##########"
echo

# Install Tailwind CSS and its dependencies
echo
echo "Installing Tailwind CSS"
echo
# npm install -D tailwindcss postcss autoprefixer
# npx tailwindcss init -p
npm install tailwindcss @tailwindcss/vite
echo

echo
echo "Installing daisyUi"
echo
npm i daisyui@latest
echo

# Configure Vite to use Tailwind CSS
if file_exists "vite.config.js"; then

	# Clear the content of the "vite.config.js" file
	> ./vite.config.js

	# Re-crete the "vite.config.js" file with Tailwind CSS plugin
	echo "import { defineConfig } from 'vite'" >> ./vite.config.js
	echo "import react from '@vitejs/plugin-react-swc'" >> ./vite.config.js
	echo "import tailwindcss from '@tailwindcss/vite'" >> ./vite.config.js
	echo >> ./vite.config.js
	echo "export default defineConfig({" >> ./vite.config.js
	echo "  plugins: [" >> ./vite.config.js
	echo "    tailwindcss()," >> ./vite.config.js
	echo "		react()," >> ./vite.config.js
	echo "  ]," >> ./vite.config.js
	echo "})" >> ./vite.config.js
fi

# Check if the file "./src/index.css" exists
if file_exists "./src/index.css"; then

	# Clear index.css before appending directives
	> ./src/index.css

	# Append Tailwind directives at the end of the file
	# echo "@tailwind base;" >> ./src/index.css
	# echo "@tailwind components;" >> ./src/index.css
	# echo "@tailwind utilities;" >> ./src/index.css
	echo '@import "tailwindcss";' >> ./src/index.css
	echo '@plugin "daisyui";' >> ./src/index.css

	echo
	echo "Appended Tailwind directives to ./src/index.css"
else
	echo
	echo "Error: ./src/index.css not found"
	echo
fi

# # Create a new file "tailwind.config.js" in the root directory
# touch ./tailwind.config.js

# # Check if the file "tailwind.config.js" exists
# if file_exists "tailwind.config.js"; then

# 	# Clear the content of the "tailwind.config.js" file
# 	> tailwind.config.js

# 	# Create Tailwind template paths in "tailwind.config.js"
# 	# echo "/** @type {import('tailwindcss').Config} */" >> tailwind.config.js
# 	echo "export default {" >> tailwind.config.js
# 	echo "  content: [" >> tailwind.config.js
# 	echo "    \"./index.html\"," >> tailwind.config.js
# 	echo "    \"./src/**/*.{js,ts,jsx,tsx}\"," >> tailwind.config.js
# 	echo "  ]," >> tailwind.config.js
# 	echo "  theme: {" >> tailwind.config.js
# 	echo "    extend: {}," >> tailwind.config.js
# 	echo "  }," >> tailwind.config.js
# 	echo "  daisyui: {" >> tailwind.config.js
# 	echo "    themes: [\"light\", \"dark\"]," >> tailwind.config.js
# 	echo "  }," >> tailwind.config.js
# 	echo "  plugins: [" >> tailwind.config.js
# 	echo "    require(\"daisyui\")" >> tailwind.config.js
# 	echo "  ]," >> tailwind.config.js
# 	echo "}" >> tailwind.config.js
# 	echo
# 	echo
# 	echo "Modified Tailwind template paths in 'tailwind.config.js'."
# else
# 	echo
# 	echo "Error: tailwind.config.js not found"
# fi

if file_exists "./index.html"; then

	# Add the "data-theme" attribute to the "html" tag (apply daisyUi light theme by default)
	sed -i 's/<html lang="en">/<html lang="en" data-theme="dark">/' index.html
	echo
	echo "Added 'data-theme' attribute to the 'html' tag in 'index.html'."
	echo
else
	echo
	echo "Error: ./index.html not found"
	echo
fi

echo
echo -e "\e[33m TAILWIND + daisyUI DEPLOYED\e[0m"
echo
