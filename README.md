# TaskAutomator

## Project overview

This project provides `bash` scripts designed for Unix-like operating systems (Linux and macOS). These scripts aim to streamline workflows and allow users to focus on priority tasks. The instructions provided here are for `Ubuntu 22.04 LTS`.

The initial set of scripts automates the setup of a `Vite + React` development environment, including some dependencies and configurations. However, the project is designed to be extensible and will eventually include scripts for a broader range of tasks.

> It is important to note that if any external dependencies change their installation or usage methods, the corresponding scripts will need to be updated.

## Usage on Unix-like Systems

This section provides instructions on how to make the scripts executable and set up aliases for easy access.

### Making Scripts Executable

Scripts are non-executable by default for security reasons. To make the [vite-full.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-full.sh) and [deployment scripts](https://github.com/RabbitHole26/taskAutomator/tree/main/vite-full-deployment-scripts) executable, follow these steps:

1. Open your terminal.
2. Navigate to the root directory containing the script.
3. Run the following command:

```
chmod +x vite-full.sh
chmod +x chmod +x vite-full-deployment-scripts/*.sh
```

### Setting Up Aliases in Ubuntu 22.04 LTS

Aliases allow you to create shortcuts for your scripts. Here’s how to set up an alias for running the [vite-full.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-full.sh) script and an alias to source the alias file itself.

1. Open your terminal.
2. Create or edit your aliases file. You can use `nano` or any text editor of your choice:

```
nano ~/.bash_aliases
```

3. Add the following lines to the `~/.bash_aliases` file:

```
alias <alias-name>='<absolute-path>/vite-full.sh'
alias aliass='source ~/.bash_aliases'
```

> Please note that alias for the aliases file is defined as `aliass` with double `s` to prevent conflicts with the `alias` command natively available in `Ubuntu 22.04 LTS`.

> Replace `<absolute-path>` with with the absolute path to your [vite-full.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-full.sh) script.

> Replace `<alias-name>` with the name of alias which will be used to run the script.

4. Save the file and exit the editor (`Ctrl + S` to save and `Ctrl + X` to exit in `nano`).

5. Apply the aliases by running:

```
source ~/.bash_aliases
```

Now you should be able to run your main script using the alias of your choice and reload your aliases using `aliass`.

### Using the script

To use the script, follow these steps:

1. Ensure the scripts are executable by running the chmod commands as described above.
2. Set up the aliases as outlined in the aliases section.
3. Execute the main script with the alias or directly.

> To run the script directly (without an alias), you will need to provide the relative or absolute path to the script. For this reason, it is recommended to use aliases.

## Customizing Dependency Installation

By commenting out the deployment script lines in the [vite-full.sh](https://github.com/RabbitHole26/taskAutomator/blob/main/vite-full.sh) script, you can choose which dependencies to install. For example, if you don't want to install `tailwind-daisyUi`, you can comment out the relevant line:

### Original (dependency installation enabled):

```
# #######################################################################################
# DEPLOY TAILWIND + daisyUI
# #######################################################################################

"$deployment_script_dir/tailwind-daisyUi.sh"
```

### Modified (dependency installation disabled):

```
# #######################################################################################
# DEPLOY TAILWIND + daisyUI
# #######################################################################################

# "$deployment_script_dir/tailwind-daisyUi.sh"
```

> Commenting out `"$deployment_script_dir/tailwind-daisyUi.sh"` will skip the installation of this dependency.

This flexibility allows you to customize your environment based on your project needs.

## Adding Your Own Scripts to TaskAutomator

TaskAutomator is designed to be extensible, allowing you to add your own scripts to automate additional tasks. Here’s a step-by-step guide on how to integrate your own scripts into the TaskAutomator framework.

1. **Write Your Script**: Develop your script using `bash`. Ensure it performs the desired tasks efficiently and includes necessary error handling.
2. **Save the Script**: Place your script in your root script directory (or any designated directory for custom scripts). For consistency, it’s recommended to use a clear naming convention.
3. **Make Your Script Executable**: Set the execute permission for your script as explained in [Making Scripts Executable](#making-scripts-executable).

## Caveats

Each [deployment script](https://github.com/RabbitHole26/taskAutomator/tree/main/vite-full-deployment-scripts) contains hardcoded instructions for installing dependencies. If a dependency author changes the installation process, the corresponding deployment script must be updated. Always check the official documentation of the dependencies for any updates or changes.

## License
This project is licensed under the MIT License. See the [LICENSE](https://github.com/RabbitHole26/taskAutomator/blob/main/LICENSE) file for details.
