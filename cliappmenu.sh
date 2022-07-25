#!/bin/bash
#
# ©2022 Copyright 2022 Robert D. Chin
# Email: RDevChin@Gmail.com
#
# Usage: bash cliappmenu.sh
#        (not sh cliappmenu.sh)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# +----------------------------------------+
# |        Default Variable Values         |
# +----------------------------------------+
#
VERSION="2022-07-25 13:02"
#
# Set THIS_FILE to the name of this script file.
THIS_FILE=$(basename $0)
#
# Set to a file name used for the generated menu code.
GENERATED_FILE=$THIS_FILE"_menu_generated.lib"
#
# Set the location of the "cliapp-dir" sub-directory.
# Use a sub-directory where you have privileges to edit the library files
# in order to edit the application menu item data.
#
# If puting the directory within the user's Home directory, then you
# cannot use the tilde "~" symbol to represent the user's Home Directory
# but must use the long-hand full-name of the user's Home Directory.
#
# You need to specify CLI_DIR.
#
# Factory setting is CLI_DIR="/home/<username>/cliapp-dir"
#
#
#================================================================================
# EDIT THE LINE BELOW TO SET THE DIRECTORY OF THE SUB-MENU "cliapp-dir"
# WHICH CONTAINS ALL THE SUB-MENU LIBRARY FILES.
#================================================================================
#
#
CLI_DIR="/home/USER/cliapp-dir"
#
if [ ! -d "$CLI_DIR" ] ; then
   # Blank the screen.
   clear
   #
   # Format message display for 80x24 terminal display resolution.
   #
   echo "CLI_DIR variable is not set correctly."
   echo
   echo "Current value is: \"CLI_DIR=$CLI_DIR\""
   echo "           Error: This directory path does not exist."
   echo
   echo "You may have to create a new sub-directory in your home directory"
   echo "to keep all the scripts and library files together and organized."
   echo
   echo "   NOTE: The sub-directory will contain all library scripts"
   echo "         EXCEPT cliappmenu.sh, cliappmenu.lib, common_bash_function.lib."
   echo "         which should be in the /home/<username>/ directory."
   echo
   echo "Edit file cliappmenu.sh to set CLI_DIR correctly to a valid directory path."
   echo "It is located under Section \"Default Variable Values\" of file cliappmenu.sh."
   echo
   echo "Here is the command to set CLI_DIR using the Sed application:"
   echo "Example: (where actual user name is \"robert\")."
   echo "         Sub-directory I used is \"/home/robert/cliapp-dir\""
   echo "         but you can name your directory whatever you want."
   echo
   echo "sed -i 's|^CLI_DIR=\"/home/USER/cliapp-dir\"|CLI_DIR=\"/home/robert/cliapp-dir\"|g' cliappmenu.sh"
   #
   # Display message and wait for user input.
   echo
   echo -n "Press '"Enter"' key to continue."
   read X
   unset X  # Throw out this variable.
   #
   # Exit script and return to command-line.
   exit 1
fi
#
# +----------------------------------------+
# |          Source library files          |
# +----------------------------------------+
#
source cliappmenu.lib
source $CLI_DIR/cli-common.lib
source $CLI_DIR/cli-web-sites.lib
source $CLI_DIR/cli-favorites.lib
#
# Source library which contains f_script_path.
source common_bash_function.lib
#
# Set variables THIS_DIR, SCRIPT_PATH to directory path of script.
f_script_path
#
# Set Temporary file using $THIS_DIR from f_script_path.
TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
#& Brief Description
#&
#& This script will run CLI (Command-Line Interface) applications which the
#& user selects by a series of menus arranged by application categories.
#&
#& This script displays its menus using "CLI text", "Dialog" or "Whiptail"
#& interface modes. Each menu is created from its library file where the
#& menu option data is stored in lines of text with field delimiters.
#& So each menu requires a corresponding library file with the menu data.
#&
#& The functions within the library, common_bash_function.lib create and
#& display the menus. The menus are created by reading the text lines from
#& the menu's library file and they are included in arrays which are used
#& to construct the menu and the menu is displayed with plain text,
#& "Dialog", or "Whiptail" inteface modes.
#&
#& Required scripts:
#& cliappmenu.sh, cliappmenu.lib, common_bash_function.lib, and all scripts
#& and libraries in the sub-directory, cliapp-dir.
#&
#& Usage: bash cliappmenu.sh
#&        (not sh cliappmenu.sh)
#&
#&    This program is free software: you can redistribute it and/or modify
#&    it under the terms of the GNU General Public License as published by
#&    the Free Software Foundation, either version 3 of the License, or
#&    (at your option) any later version.
#&
#&
#&    This program is distributed in the hope that it will be useful,
#&    but WITHOUT ANY WARRANTY; without even the implied warranty of
#&    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#&    GNU General Public License for more details.
#&
#&    You should have received a copy of the GNU General Public License
#&    along with this program. If not, see <https://www.gnu.org/licenses/>.
#&
#& See complete GNU General Public License by using the "Main Menu" and
#& selecting "Information" and then selecting "License".
#
# +----------------------------------------+
# |             Help and Usage             |
# +----------------------------------------+
#
#? When selecting application menu options:
#?
#? 1. The first prompt allows the user to select the application.
#?
#? 2. The second promt allows the user to enter application parameters.
#?
#?    Example: The selected application is the web browser "elinks".
#?    Under the second prompt, you can enter:
#?
#?                         elinks --help
#?                         elinks -version
#?                         man elinks
#?                         elinks slashdot.org
#?
#?
#?    Usage: bash cliappmenu.sh [OPTION(S)]
#?
#? Examples:
#?
#? bash cliappmenu.sh --help     Displays this help message using Cmd-line UI.
#?                    -?
#?
#? bash cliappmenu.sh --about    Displays script version.
#?                    --version
#?                    --ver
#?                     -v
#?
#? bash cliappmenu.sh --history  Displays script code history.
#?                    --hist
#
# +----------------------------------------+
# |                Code Notes              |
# +----------------------------------------+
#
#    1) Edit any menu item or menu choice by editing lines within the
#       section: "Customize Menu choice options below"
#
#    2) Each line starting with the comment "#@@" is a menu item or choice.
#
#    3) These lines may be added/deleted or edited.
#
# +----------------------------------------+
# |           Code Change History          |
# +----------------------------------------+
#
## Code Change History
##
## (After each edit made, please update Code History and VERSION.)
##
## Includes changes to cliappmenu.lib, cli-common.lib.
##
## 2022-07-25 *Section "Code Change History" updated for version 5.0 "Gail".
##            *Section "Default Variable Values" change error message display
##             at start-up of script to not use f_message or $TEMP_FILE.
##
## 2022-07-24 *Release version 5.0 "Gail".
##            *f_create_a_menu_cliappmenu, f_eval_funct, f_app_install added
##             call to f_configure_use to restore UI text colors if an error
##             occurs during app eval or app install.
##            *README and EDIT_HISTORY updated documentation.
##            *Section "Main Program" improved documentation.
##            *Section "Default Variable Values" bug fixed TEMP_FILE needed
##             to be defined earlier in the section when used for error
##             messages at start-up of script.
##
## 2022-07-23 *README updated documentation for new menu structure.
##
## 2022-07-22 *Section "Network", "Network - Monitors Structure",
##            "Office - Text Converters", "Text - Editors",
##            "Text - Markup - Documents", "Text - Tools" bug fixed.
##
## 2022-07-21 *Section "System" updated to latest standards.
##
## 2022-07-07 *Section "Packages", "Screens", "Screen-savers", and
##            "Screen-Tools", "Video" updated to latest standards.
##
## 2022-07-05 *Section "Office" updated to latest standards.
##
## 2022-07-01 *Section "Network" updated to latest standards.
##
## 2022-06-29 *Section "Games Menu", "Graphics Menu",  "Internet Menu"
##             updated to latest standards.
##
## 2022-06-27 *Secation "Education Menu", "Environment Menu", "File Menu"
##             updated to latest standards.
##
## 2022-06-26 *Section "Audio Menu", "Database Menu", Development Menu"
##             updated to latest standards.
##
## 2022-06-24 *Development on version 5.0 "Gail" started.
##             New process to display menus, allows multiple menu item data to
##             be stored in one library file. All menus belonging to a category
##             are consolidated into the corresponiding library file.
##            *Section "CLI Action Menu", "CLI Application Menu",
##             "Configuration Menu", "Information Menu" updated to latest
##             standards.
##
## 2022-04-25 *Section "Default Variable Values" added instructions to set
##             variable "CLI_DIR".
##
## 2021-07-09 *f_config, f_config_update_font_color, f_config_update_ui
##             bugs fixed and updated format of file ~/.cliappmenu.cfg.
##
## 2021-07-04 *f_config_dialog, f_config_whiptail, f_config_install added
##             feature to install Dialog or Whiptail as needed when
##             selecting it as the default UI.
##            *f_main_search bug fixed delete TEMP_FILE after use.
##            *f_search_app_add moved from cli-common.lib to cliappmenu.lib
##             to keep it with the other Search Menu functions.
##
## 2021-07-01 *Testing version 4.0 "Farrah".
##            *Fixed bug with user-selected text UI colors not displaying.
##
## 2021-05-19 *Main Menu option Search fixed bugs. Updated README.
##
## 2021-06-20 *Updated documentation in README.
##
## 2021-06-19 *Main Menu options Applications, Favorites, Search,
##             Configure, Information, Help are now working.
##
## 2021-06-18 *Main Menu options Applications, Favorites, Search,
##             Configure, Help are now working.
##
## 2021-06-16 *Main Menu options Applications, Favorites, Configure, About,
##             Code History, Help are now working.
##            *BUG: In application menus, if enter a name "morsegen" the
##             previous application "morse" will be selected instead when
##             using the Text UI. Not a problem in Dialog or Whiptail.
##
## 2021-06-14 *main_configure.lib update config file functions.
##            *Section "Default Variable Values" update list of libraries.
##
## 2021-04-22 *Development on version 4.0 "Farrah" started.
#
# +------------------------------------+
# |     Function f_display_common      |
# +------------------------------------+
#
#     Rev: 2021-03-31
#  Inputs: $1=UI - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2=Delimiter of text to be displayed.
#          $3="NOK", "OK", or null [OPTIONAL] to control display of "OK" button.
#          $4=Pause $4 seconds [OPTIONAL]. If "NOK" then pause to allow text to be read.
#          THIS_DIR, THIS_FILE, VERSION.
#    Uses: X.
# Outputs: None.
#
# Summary: Display lines of text beginning with a given comment delimiter.
#
# Dependencies: f_message.
#
f_display_common () {
      #
      # THIS_FILE is defined at the beginning of this script under the
      # Section "Default Variable Values".
      #
      # THIS_FILE is used to display the "Brief Description", "Code History"
      # and "Help and Usage" sections within this script.
      #
      # WARNING: Do not define $THIS_FILE within a library script.
      #
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
      #
      # Set $VERSION according as it is set in the beginning of $THIS_FILE.
      X=$(grep --max-count=1 "VERSION" $THIS_FILE)
      # X="VERSION=YYYY-MM-DD HH:MM"
      # Use command "eval" to set $VERSION.
      eval $X
      #
      echo "Script: $THIS_FILE. Version: $VERSION" > $TEMP_FILE
      echo >>$TEMP_FILE
      #
      # Display text (all lines beginning ("^") with $2 but do not print $2).
      # sed substitutes null for $2 at the beginning of each line
      # so it is not printed.
      sed -n "s/$2//"p $THIS_DIR/$THIS_FILE >> $TEMP_FILE
      #
      case $3 in
           "NOK" | "nok")
              f_message $1 "NOK" "Message" $TEMP_FILE $4
           ;;
           *)
              f_message $1 "OK" "(use arrow keys to scroll up/down/side-ways)" $TEMP_FILE
           ;;
      esac
      #
} # End of function f_display_common.
#
# +----------------------------------------+
# |          Function f_menu_main          |
# +----------------------------------------+
#
#     Rev: 2021-06-18
#  Inputs: $1 - "text", "dialog" or "whiptail" the preferred user-interface.
#    Uses: ARRAY_FILE, GENERATED_FILE, MENU_TITLE.
# Outputs: None.
#
# Summary: Display Main-Menu.
#          This Main Menu function checks its script for the Main Menu
#          options delimited by "#@@" and if it does not find any, then
#          it it defaults to the specified library script.
#
# Dependencies: f_menu_arrays, f_create_show_menu.
#
f_menu_main () {
      #
      # Create and display the Main Menu.
      #
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_menu_main_temp.txt"
      #
      # GENERATED_FILE (The name of a temporary library file which contains the code to display the sub-menu).
      GENERATED_FILE=$THIS_DIR/$THIS_FILE"_menu_main_generated.lib"
      #
      # Note: ***If Menu title contains spaces,
      #       ***the size of the menu window will be too narrow.
      #
      # Menu title MUST use underscores instead of spaces.
      MENU_TITLE="CLI_Action_Menu"
      #
      # ARRAY_FILE (Temporary file) includes menu items imported from $ARRAY_SOURCE_FILE of a single menu.
      ARRAY_FILE=$THIS_DIR/$THIS_FILE"_menu_array_generated.lib"
      #
      #
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $ARRAY_FILE AS THE ACTUAL FILE NAME (LIBRARY)
      # WHERE THE MENU ITEM DATA IS LOCATED. THE LINES OF DATA ARE PREFIXED BY "#@@".
      #================================================================================
      #
      #
      # Specify library file name with menu item data.
      # ARRAY_SOURCE_FILE (Not a temporay file) includes menu items from multiple menus.
      # ARRAY_SOURCE_FILE="[FILENAME_GOES_HERE]"
      ARRAY_SOURCE_FILE="$THIS_DIR/cliappmenu.lib"
      #
      # List of inputs for f_create_menu_x.
      #
      #  Inputs: $1 - "text", "dialog" or "whiptail" The command-line user-interface application in use.
      #          $2 - GENERATED_FILE (The name of a temporary library file containing the suggested phrase "generated.lib" which contains the code to display the sub-menu).
      #          $3 - MENU_TITLE (Title of the sub-menu)
      #          $4 - TEMP_FILE (Temporary file).
      #          $5 - ARRAY_FILE (Temporary file) includes menu items imported from $ARRAY_SOURCE_FILE of a single menu.
      #          $6 - ARRAY_SOURCE_FILE (Not a temporary file) includes menu items from multiple menus.
      #
      if [ $1 = "text" ] ; then
         # Restore user-selected CLI colors to terminal. Not applicable for "Dialog" or "Whiptail".
         # Why needed? Function f_message uses application "Less" to display pages of text.
         # But "Less" resets the terminal's colors to white on black.
         f_configure_use $1
      fi
      #
      f_create_a_menu_cliappmenu $1 $GENERATED_FILE $MENU_TITLE $TEMP_FILE $ARRAY_FILE $ARRAY_SOURCE_FILE
      #
      if [ -e $TEMP_FILE ] ; then
         rm $TEMP_FILE
      fi
      #
      if [ -e  $GENERATED_FILE ] ; then
         rm  $GENERATED_FILE
      fi
      #
} # End of function f_menu_main.
#
#
# **************************************
# **************************************
# ***     Start of Main Program      ***
# **************************************
# **************************************
#     Rev: 2021-06-28
#
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
# Blank the screen.
clear
#
echo "Running script $THIS_FILE"
echo "***   Rev. $VERSION   ***"
echo
# pause for 1 second automatically.
sleep 1
#
# Blank the screen.
clear
#
#***************************************************************
# Process Any Optional Arguments and Set Variables THIS_DIR, GUI
#***************************************************************
#
# If command already specifies GUI, then do not detect GUI.
# i.e. "bash menu.sh dialog" or "bash menu.sh text".
if [ -z $GUI ] ; then
   # Test for GUI (Whiptail or Dialog) or pure text environment.
   f_detect_ui
fi
#
# Initialize variables GUI, FCOLOR, BCOLOR.
# Does the file ~/.cliappmenu.cfg exist and is the UI and color set?
#
# Function f_config within file cliappmenu.lib checks to see if the
# file file ~/.cliappmenu.cfg exists, creates one if needed or if it does
# exist, it will check to see if the variables are initialized. Then it
# will run function f_main_config within file ~/.cliappmenu.cfg to set the
# variables GUI, FCOLOR, BCOLOR.
#
# Does cliappmenu.cfg set GUI?
f_config GUI
#
# Does cliappmenu.cfg set Text Colors?
f_config FCOLOR
#
# Apply the font colors
f_term_color $FCOLOR $BCOLOR
#
# Since f_arguments follows f_term_color, any UI specified as an argument
# will override the UI settings in the ~/.cliappmenu.cfg file.
# i.e. If the file .cliappmenu.cfg specifies "text" but the CLI command is
#      "bash cliappmenu.sh dialog", then the selected UI will be "Dialog".
#
# Test for Optional Arguments.
# Also sets variable UI.
f_arguments $1 $2
#
# Manual Override of UI Environment for testing purposes.
#GUI="whiptail"  # Diagnostic line.
#GUI="dialog"    # Diagnostic line.
#GUI="text"      # Diagnostic line.
#
# Test for X-Windows environment. Cannot run in CLI for LibreOffice.
# if [ x$DISPLAY = x ] ; then
#    f_message text "OK" "\Z1\ZbCannot run LibreOffice without an X-Windows environment.\ni.e. LibreOffice must run in a terminal emulator in an X-Window.\Zn"
# fi
#
# Test for BASH environment.
f_test_environment $1
#
# If an error occurs, the f_abort() function will be called.
# trap 'f_abort' 0
# set -e
#
#********************************
# Show Brief Description message.
#********************************
#
f_about $GUI "NOK" 1
#
#*******************
# Display Main Menu.
#*******************
#
f_menu_main $GUI
#
# Delete temporary files.
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
#
# Nicer ending especially if you chose custom colors for this script.
# Blank the screen.
clear
#
exit 0  # This cleanly closes the process generated by #!bin/bash.
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
        #
# All dun dun noodles.

