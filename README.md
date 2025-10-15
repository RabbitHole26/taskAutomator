# TaskAutomator

## Version

### Current version: 0.0.5
- **Release Date**: October 15, 2025
- **Features**:
  - Updated mechanism for dependency selection — now fully managed via `install-config.env` instead of editing the main script:
    - Added automatic creation of a default `install-config.env` file if it does not exist.
    - Added verification of key-value pairs in `install-config.env` using the `allowed_keys` array.
    - Expanded deployment script registration to require mapping each script both in the `allowed_keys` array and in the “Deployment scripts” section of the main script.
  - Updated the Vite installation step to suppress default prompts asking to install dependencies or run the project (these are handled by the script).

### Version history:
  - **0.0.5** (September 22, 2025)
    - Split `tailwind-daisyUi.sh` into two separate scripts, `tailwind.sh` and `daisyUi.sh`, to allow finer control over which packages are installed by the `vite-react.sh` script.
    - Clears the content of the `README.md` file when deploying the `vite-react.sh` script.
    - Fixed `is_commented` function to correctly handle file names containing regex-valid characters.
  - **0.0.4** (March 30, 2025)
    - Updated `tailwind-daisyUi.sh` to install the latest stable version of DaisyUI instead of the beta version.
    - Minor optimizations in `vite-react.sh` file.
  - **0.0.3** (January 27, 2025)  
    - Updated `tailwind-daisyUi.sh` to reflect new installation steps for Tailwind CSS v4 and DaisyUI v5 beta.
    - Added a button with DaisyUI classes to `App.jsx` to verify successful installation.
  - **0.0.2** (January 21, 2025)  
    - Added option to use Google Chrome as the default browser for the 'dev' script.
    - Supports selection between 'Windows + WSL' and 'Ubuntu' setups, based on default Chrome installation paths for Windows 11 and Ubuntu 24.04.
  - **0.0.1** (January 21, 2025)
    - Tailwind theme integration.
  - **0.0.0** (Initial drafts of deployment scripts)

## Project overview

This project provides `bash` scripts designed for Unix-like operating systems (Linux and macOS). These scripts aim to streamline workflows and allow users to focus on priority tasks. The instructions provided here are for `Ubuntu 22.04 LTS`.

The initial set of scripts automates the setup of a `Vite + React` development environment, including some dependencies and configurations. However, the project is designed to be extensible and will eventually include scripts for a broader range of tasks.

> ⚠️ It is important to note that if any external dependencies change their installation or usage methods, the corresponding scripts must be updated.

## Usage on unix-like systems

This section provides instructions on how to make the scripts executable and set up aliases for easy access.

### Making scripts executable

Scripts are non-executable by default for security reasons. To make the [vite-react.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-react.sh) and [deployment scripts](https://github.com/RabbitHole26/taskAutomator/tree/main/vite-react-deployment-scripts) executable, follow these steps:

1. Open your terminal.
2. Navigate to the root directory containing the script.
3. Run the following command:

```bash
chmod +x vite-react.sh
chmod +x vite-react-deployment-scripts/*.sh
```

### Setting up aliases in Ubuntu 22.04 LTS (optional)

Aliases allow you to create shortcuts for your scripts. Here’s how to set up an alias for running the [vite-react.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-react.sh) script and an alias to source the alias file itself.

1. Open your terminal.
2. Create or edit your aliases file. You can use `nano` or any text editor of your choice:

```bash
nano ~/.bash_aliases
```

3. Add the following lines to the `~/.bash_aliases` file:

```bash
# alias for the vite-react.sh script
alias <alias-name>='<absolute-path>/vite-react.sh'

# alias for reloading bash_aliases 
alias reload_aliases='source ~/.bash_aliases'

# alias for accessing the file with aliases
alias aliass='nano ~/.bash_aliases'
```

> 👉 Please note that alias for the aliases file is defined as `aliass` with double `s` to prevent conflicts with the `alias` command natively available in `Ubuntu 22.04 LTS`. You need to be aware of this when naming your aliases in order to prevent conflicts with existing commands.

> 👉 Replace `<absolute-path>` with the absolute path to your [vite-react.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-react.sh) script.

> 👉 Replace `<alias-name>` with the name of the alias which will be used to run the script.

4. Save the file and exit the editor (`Ctrl + S` to save and `Ctrl + X` to exit in `nano`).
5. Apply the aliases by running:

```bash
source ~/.bash_aliases
```

Now you should be able to run your main script using the alias of your choice and reload your aliases using `aliass`.

### Installation configuration (install-config.env)

_**Overview**_

Dependency installation is now fully managed by a configuration file: `install-config.env`. The file have to reside in the root directory of the script.

This file contains a list of dependencies and boolean flags (`true` or `false`) as key value pairs for each deployment script, for example:

```bash
INSTALL_TAILWIND=true
INSTALL_DAISYUI=true
INSTALL_STYLED_COMPONENTS=false
INSTALL_REACT_ROUTER_DOM=true
```

_**Automatic creation**_

If the file does not exist, the script will:

1. Notify the user that it is missing.
2. Create a **default configuration file** listing all available dependencies with the flag set to `true`.
3. Terminate execution so that the user can review and modify the file before re-running.

_**Verification mechanism**_

When the script starts, the integrity of the `install-config.env` will be verified using predefined `allowed_keys` array.

How it works:

- The script reads the file line by line, ignoring comments and blank lines.
- Each key is validated against the `allowed_keys` array.
- Each value is checked to ensure it is strictly `true` or `false`.
- If an invalid key or value is detected:
  - The script displays an **error message** specifying the issue.
  - It sets an internal flag `invalid_found=true`.
  - After checking all lines, if issues exist, the script is terminated with instructions on how to fix the file.
- If no errors are found:
  - A success message is displayed and script continues executing.

This ensures the users cannot proceed with malformed or incorrectly named configuration entries.

### Using the script

To use the script, follow these steps:

1. Ensure the scripts are executable by running the chmod commands as described in [Making Scripts Executable](#making-scripts-executable).
2. Set up the aliases as outlined in the aliases section (optional but recommended).
3. Execute the main script with the alias or directly.

> To run the script directly (without an alias), you need to provide the relative or absolute path to the script. Therefore, it is recommended to use aliases.

> ⚠️ `vite-react.sh` is designed to be executed in the root project directory. It always treats the current directory as the root project directory.

## Adding your own deployment scripts to vite-react.sh

The `vite-react.sh` script is designed to be extensible, allowing you to add your own deployment scripts to automate additional tasks. Here’s a step-by-step guide:

1. **Write Your Script**: Develop your script using `bash`. Ensure it performs the desired tasks efficiently and includes necessary error handling.
2. **Save the Script**: Place your script in the `vite-react-deployment-scripts` directory located in the root directory of taskAutomator as `.sh` file. For consistency, it’s recommended to use a clear naming convention.
3. **Add the path to your script to vite-react.sh**: The path needs to meet the following format `"$deployment_script_dir/<script-name>.sh"`.
4. **Make Your Script Executable**: Set the execute permission for your script as explained in [Making Scripts Executable](#making-scripts-executable).
5. **Add your script to the `allowed_keys` array**: Edit `vite-react.sh` script and append a new key representing your script. Example:

```bash
allowed_keys=(
  ...
  MY_CUSTOM_DEPENDENCY_SCRIPT
)
```

6. **Add your script to the deployment section**: In the `DEPLOYMENT SCRIPTS` section of `vite-react.sh`, link your new script to the corresponding key:

```bash
...
[ "$MY_CUSTOM_SCRIPT" = true ] && "$deployment_script_dir/my-custom-script.sh"
```

7. **Update the installation config file**: Add the new key value pair representing your script to `install-config.env`:

```bash
INSTALL_MY_CUSTOM_TOOL=true
```

> ⚠️ All new scripts must be registered both in `allowed_keys` and the `DEPLOYMENT SCRIPTS` section to ensure they are validated and executed properly.

## Caveats

- Each [deployment script](https://github.com/RabbitHole26/taskAutomator/tree/main/vite-react-deployment-scripts) contains hardcoded instructions for installing dependencies. If a dependency author changes the installation process, the corresponding deployment script must be updated. Always check the official documentation of the dependencies for any updates or changes.

- The `RUN VSCODE` section in [vite-react.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-react.sh) includes a command to run the `dev` script located in the `package.json` file of the scaffolded project. This command is delayed by 2 seconds (`sleep 2 && npm run dev`). You might want to increase the delay depending on how fast your machine is able to load VS Code.

- Both `tailwind.sh` and `daisyUi.sh` modify the `index.css` file in the Vite project. Keep this in mind when changing their execution order, as `tailwind.sh` clears `index.css` before applying its changes.

- Vite installation behavior: The `vite-react.sh` script disables the default Vite interactive prompts that ask the user to:
  - Install NPM.
  - Run the project immediately. 

## License
This project is licensed under the MIT License. See the [LICENSE](https://github.com/RabbitHole26/taskAutomator/blob/main/LICENSE) file for details.
