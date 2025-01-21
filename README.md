# TaskAutomator

## Version

### Current version: 0.0.2
- **Release Date**: January 21, 2025
- **Features**:
  - Added option to use Google Chrome as the default browser for the 'dev' script.
  - Supports selection between 'Windows + WSL' and 'Ubuntu' setups, based on default Chrome installation paths for Windows 11 and Ubuntu 24.04.

### Version history:
  - **0.0.0** (Initial drafts of deployment scripts)
  - **0.0.1** (Tailwind theme integration)

## Project overview

This project provides `bash` scripts designed for Unix-like operating systems (Linux and macOS). These scripts aim to streamline workflows and allow users to focus on priority tasks. The instructions provided here are for `Ubuntu 22.04 LTS`.

The initial set of scripts automates the setup of a `Vite + React` development environment, including some dependencies and configurations. However, the project is designed to be extensible and will eventually include scripts for a broader range of tasks.

> It is important to note that if any external dependencies change their installation or usage methods, the corresponding scripts will need to be updated.

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

### Setting up aliases in Ubuntu 22.04 LTS

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

### Using the script

To use the script, follow these steps:

1. Ensure the scripts are executable by running the chmod commands as described above.
2. Set up the aliases as outlined in the aliases section.
3. Execute the main script with the alias or directly.

> To run the script directly (without an alias), you need to provide the relative or absolute path to the script. Therefore, it is recommended to use aliases.

> IMPORTANT: `vite-react.sh` is designed to be executed in the root project directory. If you execute the script outside the designated project directory, it will treat the current directory as the root project directory.

## Customizing dependency installation

By commenting out the deployment script lines in the [vite-react.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-react.sh) script, you can choose which dependencies to install. For example, if you don't want to install `tailwind-daisyUi`, you can comment out the relevant line:

### Original (dependency installation enabled):

```bash
# #######################################################################################
# DEPLOY TAILWIND + daisyUI
# #######################################################################################

"$deployment_script_dir/tailwind-daisyUi.sh"
```

### Modified (dependency installation disabled):

```bash
# #######################################################################################
# DEPLOY TAILWIND + daisyUI
# #######################################################################################

# "$deployment_script_dir/tailwind-daisyUi.sh"
```

> Commenting out `"$deployment_script_dir/tailwind-daisyUi.sh"` will skip the installation of this dependency.

This flexibility allows you to customize your environment based on your project needs.

## Adding your own deployment scripts to vite-react.sh

The `vite-react.sh` script is designed to be extensible, allowing you to add your own deployment scripts to automate additional tasks. Here’s a step-by-step guide:

1. **Write Your Script**: Develop your script using `bash`. Ensure it performs the desired tasks efficiently and includes necessary error handling.
2. **Save the Script**: Place your script in the `vite-react-deployment-scripts`. For consistency, it’s recommended to use a clear naming convention.
3. **Add the path to your script to vite-react.sh**: The path needs to meet the following format `"$deployment_script_dir/<script-name>.sh"`.
4. **Make Your Script Executable**: Set the execute permission for your script as explained in [Making Scripts Executable](#making-scripts-executable).

## Caveats

Each [deployment script](https://github.com/RabbitHole26/taskAutomator/tree/main/vite-react-deployment-scripts) contains hardcoded instructions for installing dependencies. If a dependency author changes the installation process, the corresponding deployment script must be updated. Always check the official documentation of the dependencies for any updates or changes.

The `RUN VSCODE` section in [vite-react.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-react.sh) includes a command to run the `dev` script located in the `package.json` file of the scaffolded project. This command is delayed by 2 seconds (`sleep 2 && npm run dev`). You might want to increase the delay depending on how fast your machine is able to load VS Code.

## License
This project is licensed under the MIT License. See the [LICENSE](https://github.com/RabbitHole26/taskAutomator/blob/main/LICENSE) file for details.
