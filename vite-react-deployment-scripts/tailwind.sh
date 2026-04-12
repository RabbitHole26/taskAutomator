# * Use Bash to interpret and execute this script
#!/bin/bash

# * Source the external functions file
source "$(dirname "${BASH_SOURCE[0]}")/../general-functions.sh"

echo
echo "########## DEPLOYING TAILWIND ##########"
echo

# Install Tailwind CSS and its dependencies
echo
echo "Installing Tailwind CSS"
echo
# npm install -D tailwindcss postcss autoprefixer
# npx tailwindcss init -p
npm install tailwindcss @tailwindcss/vite
echo

# Configure Vite to use Tailwind CSS
if file_exists "vite.config.js"; then

	sed -i.bak '/import react from/a\
import tailwindcss from "@tailwindcss/vite"' vite.config.js && rm vite.config.js.bak
	sed -i.bak 's/\[react()/[react(), tailwindcss(), /' vite.config.js && rm vite.config.js.bak
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

	echo
	echo "Appended Tailwind directives to ./src/index.css"
	echo
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

echo
echo -e "\e[33m TAILWIND DEPLOYED\e[0m"
echo
