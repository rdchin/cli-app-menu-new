# cli-app-menu-new
CLI Menu of Linux CLI Apps to automatically install and run CLI apps (Command Line Applications for Linux) written in BASH script. Version 4 is a total rewrite of Version 3 and uses generated menus from array data rather than hard-coded menus. The generated menus may be displayed by text, Dialog, or Whiptail user-interfaces.

#: +----------------------------------------+
#: |            Brief Description           |
#: +----------------------------------------+
#:
#: Script cliappmenu.sh is a menu of CLI applications and commands
#: to help CLI newbies to discover what a command line can do.
#:
#: The typical user is anyone who wants to learn about what types of
#: command line applications are available.
#:
#: This version 4.x IS NOT BACKWARD COMPATIBLE with 3.1 and earlier since
#: all the menus are now array driven and created as needed by creating
#: temporary menu files which are deleted when each menu is exited.
#:
#: Reading the text menu data into arrays is more efficient and it allows
#: menus to be displayed using Dialog, Whiptail, or text UI.
#:
#: The code which creates the menu arrays is contained in the library
#: "common_bash_library.lib". It can be used in any BASH script you wish.
#:
#: There are many apps_[application category].lib files because each file
#: has the data to create a single menu and there are about 134 menus in
#: this script. The file naming system is ordered by app menu category.
#: This allows easier locating of a particular apps menu file.
#:
#: Admittedly, the some of the library files for this script are big,
#: particularly "cli-common.lib" and "common_bash_function_library.lib".
#:
#: The "common_bash_function_library.lib" contains tested functions that
#: are designed to be used in any script.
#: 
#: Lastly, because the menus are now generated, there is a performance lag.
#: The script ran fine on a Raspberry Pi 2 1 GB computer.
#:
#:
#: +----------------------------------------+
#: |       HOW-TO Install this script       |
#: +----------------------------------------+
#:
#: This project is in a GitHub.com repository and can be downloaded from 
#: https://github.com/rdchin/cli-app-menu-new
#:
#:
#: 1. TEMPORARY FILES.
#:
#: This script creates a few temporary files which should be deleted as
#: each menu is exited. It will create one temporary file per menu, and
#: more temporary files to store data, if needed. All temporary files
#: are named after the file name which creates them or uses them.
#:
#: Normally "Dialog" and "Whiptail" menus are static, but I wanted dynamic
#: menus created on-the-fly as needed and did not want to have to code a
#: static menu for each application category as was done in version 3.1 and
#: earlier of this script. Thus the need for temporary files. 
#:
#: 
#: 2. A HIDDEN CONFIGURATION FILE.
#:
#: #: The configuration file: ~/.cliappmenu.cfg 
#: is a hidden file which resides in the user's home directory.
#: It is automatically created when you customize the UI and font colors.
#: It is used to save the user preferences and is created and configured
#: by the Main Menu option "Configure".
#:
#:
#: 3. FILE LOCATIONS (AND SUB-DIRECTORY).
#:
#: The files: 
#:
#: cliappmenu.sh
#: cliappmenu.lib
#: common_bash_function.lib
#:
#: need to be in your home directory /home/<username>.
#:
#: All other files need to be in sub-directory /home/<username>/cliapp-dir.
#: Where <username> represents your linux user name.
#: 
#: You can set the sub-directory to another location within your home
#: directory and/or rename it. 
#:
#: To specify the new location/name of the cliapp-dir sub-directory, 
#: edit the file, cliappmenu.sh. Near the beginning of the script,
#: within the Section "Default Variable Values" you will see the setting
#: of variable CLI_DIR which you can change to another sub-directory.
#:
#:
#:  Beginning of excerpt from script cliappmenu.sh:
#: _______________________________
#:
#: #================================================================================
#: # EDIT THE LINE BELOW TO SET THE DIRECTORY OF THE SUB-MENU "cliapp-dir"
#: # WHICH CONTAINS ALL THE SUB-MENU LIBRARY FILES.
#: #================================================================================
#: #
#: #
#: # Set the location of the "cliapp-dir" sub-directory.
#: # Use a sub-directory where you have privileges to edit the library files
#: # in order to edit the application menu item data.
#: #
#: # If puting the directory within the user's Home directory, then you
#: # cannot use the tilde "~" symbol to represent the user's Home Directory
#: # but must use the long-hand full-name of the user's Home Directory.
#: #
#: # You need to specify CLI_DIR.
#: #
#: # Factory setting is CLI_DIR="/home/<username>/cliapp-dir"
#: #
#: # CLI_DIR="/home/<username>/cliapp-dir"
#:
#: _______________________________
#: End of excerpt from script cliappmenu.sh.
#:
#:
#: 4. CHANGING THE PATH VARIABLE.
#:
#: Append the directory name to your environment $PATH:
#: Edit your /home/<username>/.bashrc or .bash_profile or .profile
#: file and add the directory by adding the lines to the end of the file,
#:                   PATH=$PATH:<User-chosen directory path>/cliapp-dir
#:                   export PATH
#:
#: When cliappmenu.sh is run i.e. "bash cliappmenu.sh",
#:
#:
#: +----------------------------------------+
#: |      Why did I write this script?      |
#: +----------------------------------------+
#:
#: I wrote this script for 3 reasons:
#: 1. I wanted a categorized list of command line applications.
#: 2. I wanted to learn bash scripting, i.e. functions, looping, tests.
#: 3. I couldn't find a cli menu to launch cli apps on the web so I thought
#:    I'd give back to the community and perhaps others could build on and
#:    improve on what I've started.
#:
#: Please enjoy . . . bob chin (2014...2021).
#:                    RDevChin@Gmail.com.
#:
#:
#: +----------------------------------------+
#: |      Why is this menu so complex?      |
#: +----------------------------------------+
#:
#: The 4 main goals of this project are:
#:
#: 1) To educate users on what Command-Line application are available.
#:
#: 2) To easily change a menu by adding/deleting a single comment line.
#:
#: 3) To easily add new sub-menus.
#:
#: 4) To automatically change the UI between text, Dialog, or Whiptail
#:    without needing to calculate dialog box sizes or screen size.
#:    (All those calculations are done for you by the f_message functions
#:    within the library, common_bash_function.lib).
#:
#: *I chose ease-of-use over complexity. Complexity creates ease-of-use.
#:
#: *I used to be a MUMPS programmer and QA analyst.
#:
#: *I used to create menus with each menu option in a line of text when I
#:  wrote software in MUMPS (now called "M") and being a QA person, my job
#:  was to try to break programs.
#:
#: *My QA background also explains this crazy documentation of everything
#:  along with the fact that I am (just) still learning bash scripting.
#:
#:
#: +----------------------------------------+
#: |             Script features            |
#: +----------------------------------------+
#:
#: *Designed for ease of extensibility and menu editing.
#:  Each menu is automatically generated and no coding is necessary.
#:
#: *Optimized for 80x24 display or 640x480 pixel displays.
#:  Run-time displayed text is no wider than 80-columns across.
#:  Run-time menus are no longer than 16 items for 24 row displays.
#:  Although the game, "Pacman for Console" needs 32 rows minimum to play.
#:
#: *You can get application help by 'man' or '--help' from the menu prompt.
#:
#: *If an application is not installed, the script can install it using
#:  package managers apt, rpm, slackpkg, pacman or for specific apps,
#:  download it from a web site for manual installation.
#:
#: *If an application needs sudo permissions, the script will automatically
#:  ask the user if sudo should be used.
#:
#: *Starting in version 4, all menus are generated on-the-fly or on-demand.
#:
#: *Menus are now generated as-needed or on-the-fly in temporary files.
#:
#:  For instance, if you open the Main Menu then go through the following
#:  sub-menus: Application Menu, System Menu, and Monitor Menu, then the
#:  script will generate only four menus contained in temporary files which
#:  are deleted as each menu is exited.
#:
#:    MENU                GENERATED TEMPORARY FILE WITH MENU CODE
#:  Main Menu         ~/cliappmenu.sh_menu_main_generated.lib
#:  Application Menu  ~/cliapp-dir/apps.lib.generated
#:  System Menu       ~/cliapp-dir/apps_system.lib.generated
#:  Monitor Menu      ~/cliapp-dir/apps_system_monitors.lib.generated
#:
#:  This is in contrast with version 3 where all the menus were hard-coded
#:  and multiple menus were contained in a single file so a unique 3-letter
#:  string to identify a given menu was required.
#:
#:  Rather than keep a list of unique 3-letter string identifiers for each
#:  menu, version 4 has a separate file for each menu.
#:
#:    MENU                LIBRARY FILE CONTAINING MENU OPTION DATA
#:
#:  Although there are many more files, this makes locating a particular
#:  menu easier and is a more organized method to store related code.
#:
#:  This makes it very easy to add new sub-menus. If you wish to create 
#:  your own custom sub-menu, just create a new library file using an 
#:  existing menu library file as a template.
#:
#:  But as of now, it means that there are over 140 library files for the
#:  over 140 menus in this script.
#:
#: *User-interfaces text (CLI), Dialog, and Whiptail are fully supported
#:  for all menus and message displays. You can switch between them using
#:  the "Configuration Menu".
#:
#:  This is done through functions contained in the library file,
#:  "common_bash_function.lib". Functions f_message and f_create_show_menu
#:  do all the work for you by automatically displaying messages in your
#:  selected user-interface and even automatically calculates the size of
#:  the message boxes for both Dialog and Whiptail.
#:
#: *More fun than just a list of CLI applications!!!
