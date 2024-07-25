# * Use Bash to interpret and execute this script
#!/bin/bash

echo
echo "########## DEPLOYING FONTAWESOME ##########"
echo
echo
echo "Installing FONTAWESOME-SVG-CORE and FREE ICON PACKAGES"
echo
npm i --save @fortawesome/fontawesome-svg-core
echo
npm i --save @fortawesome/free-solid-svg-icons
echo
npm i --save @fortawesome/free-regular-svg-icons
echo
npm i --save @fortawesome/free-brands-svg-icons
echo
echo "Installing FONTAWESOME FOR REACT"
echo
npm i --save @fortawesome/react-fontawesome@latest
echo

echo
echo -e "\e[33m FONTAWESOME DEPLOYED\e[0m"
echo
