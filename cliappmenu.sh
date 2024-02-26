#!/bin/bash
#
# ©2024 Copyright 2024 Robert D. Chin
# Email: RDevChin@Gmail.com
#
# Usage: bash cliappmenu.sh
#        (not sh cliappmenu.sh)
#
# The script cliappmenu.sh can  be run by itself as a stand-alone script.
# It will automatically download all the required files from either a
# local LAN repository or the GitHub Repository "cli-app-menu-new" website.
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
VERSION="2024-02-26 00:24"
#
# Set THIS_FILE to the name of this script file.
THIS_FILE=$(basename $0)
#
FILE_TO_COMPARE=$THIS_FILE
TEMP_FILE=$THIS_FILE"_temp.txt"
#
# Set to a file name used for the generated menu code.
GENERATED_FILE=$THIS_FILE"_menu_generated.lib"
#
#
# -----------------------------------------------
# Set the path of the "cliapp-dir" sub-directory.
# Use a sub-directory where you have privileges
# to edit the library files in order to edit the
# menu item data.
# -----------------------------------------------
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
#================================================================
#
# OPTIONAL:
#
# EDIT THE LINES BELOW TO SET REPOSITORY SERVERS AND DIRECTORIES
# AND TO INCLUDE ALL DEPENDENT SCRIPTS AND LIBRARIES TO DOWNLOAD.
#
# ALSO PLEASE EDIT f_check_version
#
# NOTE: SERVER_DIR, MP_DIR, and LOCAL_REPO_DIR only need to be
#       set if you wish to set up a repository if this code on
#       a file server. This script will use Samba to mount the
#       file server's share-point onto the local mount-point.
#
#       If any files/libraries are missing from the local PC,
#       they will be automatically downloaded from the local file
#       server or automatically downloaded from GitHub.
#================================================================
#
#
#--------------------------------------------------------------
# Set variables to mount the Local Repository to a mount-point.
#--------------------------------------------------------------
#
# LAN File Server shared directory.
# SERVER_DIR="[FILE_SERVER_DIRECTORY_NAME_GOES_HERE]"
# SERVER_DIR="//file_server/files"
SERVER_DIR="//file_server/files"
#
# Local PC mount-point directory.
# MP_DIR="[LOCAL_MOUNT-POINT_DIRECTORY_NAME_GOES_HERE]"
# MP_DIR="/mnt/file_server/files"
MP_DIR="/mnt/file_server/files"
#
# Local PC mount-point with LAN File Server Local Repository full directory path.
# Example:
#                   File server shared directory is "//file_server/files".
# Repostory directory under the shared directory is "scripts/BASH/Repository".
#                 Local PC Mount-point directory is "/mnt/file_server/files".
#
# LOCAL_REPO_DIR="$MP_DIR/[DIRECTORY_PATH_TO_LOCAL_REPOSITORY]"
# LOCAL_REPO_DIR="$MP_DIR/Local_Repository"
LOCAL_REPO_DIR="$MP_DIR/Local_Repository"
#
# Web Repository i.e. Hosted by GitHub.com or another web site.
# WEB_REPOSITORY_URL="raw.githubusercontent.com/user/project/branch"
WEB_REPOSITORY_URL="raw.githubusercontent.com/rdchin/cli-app-menu-new/main/"
#
# Warning: If the Github Repository is "Private", then anonymous downloads are not permitted.
#
#
#===========================================================================
# EDIT THE LINES BELOW TO SPECIFY THE FILE NAMES TO UPDATE.
# UPDATED FILES WILL BE COPIED FROM THE LOCAL REPOSITORY AT $LOCAL_REPO_DIR.
#
# ANY MISSING FILES WILL BE DOWNLOADED FROM EITHER THE LOCAL REPOSITORY OR
# FROM GITHUB (IF THE LOCAL REPOSITORY IS UNAVAILABLE).
#===========================================================================
#
#
# Temporary file FILE_LIST contains a list of file names of dependent
# scripts and libraries.
#
FILE_LIST=$THIS_FILE"_file_temp.txt"
#
# Format: [File Name]^[Local/Web]^[Local repository directory]^[web repository directory]/
#
echo "cliappmenu.sh^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"                 > $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "cliappmenu.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"               >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_audio.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"               >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_databases.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"           >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_development.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"         >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_education.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"           >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_environment.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"         >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_file.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"                >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_games.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"               >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_graphics.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"            >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_internet.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"            >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_network.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"             >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_office.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"              >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_packages.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"            >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_screensavers.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"        >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_screens.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"             >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_screen_tools.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"        >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_system.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"              >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "apps_video.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"               >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "cli-common.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"               >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "cli-favorites.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"            >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "cli-web-sites.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"            >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "COPYING^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"                      >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "EDIT_HISTORY^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"                 >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "LICENSE^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"                      >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "main_search_results.lib.save^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL" >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "README^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"                       >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "README.md^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"                    >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.
echo "common_bash_function.lib^Local^$LOCAL_REPO_DIR^$WEB_REPOSITORY_URL"     >> $FILE_LIST  # <<<--- INSERT ACTUAL FILE NAME HERE.

# Create a name for a temporary file which will have a list of files which need to be downloaded.
FILE_DL_LIST=$THIS_FILE"_file_dl_temp.txt"
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
#? 2. The second prompt allows the user to enter application parameters.
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
#?                               Force display to use a different UI.
#? bash cliappmenu.sh text       Use Cmd-line user-interface. (80x24 min.)
#?                    dialog     Use Dialog   user-interface.
#?                    whiptail   Use Whiptail user-interface.
#?
#? bash cliappmenu.sh --help     Displays this help message.
#?                    -?
#?
#? bash cliappmenu.sh --about    Displays script version.
#?                    --version
#?                    --ver
#?                     -v
#?
#? bash cliappmenu.sh --update   Update script.
#?                    -u
#?
#? bash cliappmenu.sh --history  Displays script code history.
#?                    --hist
#?
#? Examples using 2 arguments:
#?
#? bash cliappmenu.sh --hist text
#?                    --ver dialog
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
## 2024-02-26 *Section "Default Variable Values" added $WEB_REPOSITORY_URL.
##            *fdl_dwnld_file_from_local_repository
##             fdl_dwnld_file_from_web_site improved informational messages.
##            *fdl_mount_local improved user message.
##            *Section "Main Program" added the deleting of file $FILE_LIST
##             after checking for missing files. It was not getting deleted
##             when script used CLI parameters that did not display a menu.
##
## 2024-02-21 *fdl_download_missing_scripts
##             fdl_mount_local
##             fdl_dwnld_file_from_web_site
##             fdl_dwnld_file_from_local_repository
##             Tested downloading all files, libraries and scripts
##             and installation from GitHub.com Repository zip files.
##             Improved installation from just cliappmenu.sh as a
##             stand-alone script which will then download all other
##             necessary scripts and libraries automatically.
##
## 2024-02-20 *Release Version 6.1 "Hannah"
##
## 2024-02-19 *f_menu_main_all_menus added replacing f_menu_main.
##            *f_menu_main deleted in favor of f_menu_main_all_menus.
##            *Section "Main Program" changed from: f_menu_main
##                                    changed   to: f_menu_main_all_menus
##             These changes use the menu template "f_menu_main_all_menus"
##             which may be used for all menus. It is more versatile and
##             requires fewer passed parameters making it simpler to use.
##
## 2024-02-08 *apps_audio.lib converted to use f_menu_main_all_menus.
##             Note: f_create_a_menu_cliappmenu in cliappmenu.lib will
##                   continue to be in use until all app libraries are
##                   converted by replacing it with f_menu_main_all_menus.
##
## 2024-02-05 *f_menu_main edited using f_menu_main_all_menus (template)
##             which maintains functionality but makes maintance easier.
##            *f_menu_main_all_menus added for consistency.
##             (from template in the library, comman_bash_function.lib).
##            *Section "Help and Usage" updated to latest standards.
##            *Section "CLI Action Menu" added menu item "Version Update".
##            *f_check_version added.
##            *Section "Default Variable Values" added feature to allow the
##             download of missing files.
##            *fdl_download_missing_scripts, fdl_dwnld_file_from_web_site
##             fdl_dwnld_file_from_local_repository, fdl_source
##             fdl_dwnld_file_from_web_site, fdl_mount_local added.
##
## 2023-12-14 *Section "Main" changed from: f_test_environment $1
##                            changed   to: f_test_environment $GUI
##             If string parameter $1 was not a UI, then f_arguments would
##             exit out of the script cleanly, but really want to use $GUI
##             as the argument. (See common_bash_function.lib, f_argments).
##
## 2023-11-26 *Updated copyright year. Uploaded project to GitHub.
##
## 2023-06-21 *apps_screen_tools.lib added "neofetch" application.
##
## 2022-12-04 *Section "Network" bug fixed, some apps had a flag set
##             to run non-existent custom functions. Flag unset.
##            *f_app_cmd now properly defines variable CURRENT_FILE.
##            *Section "Search" is now working, code was incomplete.
##
## 2022-12-02 *Section "System" application menu bug fixed.
##            *f_app_cmd bug fixed; use $ARRAY_SOURCE_FILE as defined in
##             f_create_a_menu_cliappmenu.
##            *f_app_cmd bug fixed; a second version in cli-favorites.lib
##             had a hard-coded array source file and missing bug fixes
##             which caused running app to fail on the first try.
##            *f_create_a_menu_cliappmenu added $ARRAY_SOURCE_FILE.
##            *f_menu_main added deleting of ARRAY_FILE on exit.
##            *Section "Listing CLI Action Menu" change option 0. from
##             "f_exit_script" to "break" to allow f_menu_main to delete
##             all generated temporary files rather than using script
##             f_exit_script which only deletes TEMP_FILE.
##
##
## 2022-07-25 *Section "Code Change History" updated for version 5.0 "Gail".
##            *Section "Default Variable Values" changed error message so
##             at start-up of script f_message or $TEMP_FILE are not used.
##            *Section "Help and Usage" updated.
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
##             New process to display menus, allows multiple menu item data
##             to be stored in one library file. All menus belonging to a
##             category are consolidated into the corresponding library
## file.
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
# +----------------------------------------+
# |         Function f_script_path         |
# +----------------------------------------+
#
#     Rev: 2020-03-07
#  Inputs: $BASH_SOURCE (System variable).
#    Uses: None.
# Outputs: SCRIPT_PATH, THIS_DIR.
#
# Summary: Detect current directory and set path variables.
#
# Dependencies: None.
#
f_script_path () {
      #
      # BASH_SOURCE[0] gives the filename of the script.
      # dirname "{$BASH_SOURCE[0]}" gives the directory of the script
      # Execute commands: cd <script directory> and then pwd
      # to get the directory of the script.
      # NOTE: This code does not work with symlinks in directory path.
      #
      # !!!Non-BASH environments will give error message about line below!!!
      SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
      THIS_DIR=$SCRIPT_PATH  # Set $THIS_DIR to location of this script.
      #
}  # End of function f_script_path.
#
# +------------------------------------+
# |     Function f_display_common      |
# +------------------------------------+
#
#     Rev: 2024-02-24
#  Inputs: $1 - "text", "dialog" or "whiptail" the command-line user-interface in use.
#          $2 - Delimiter of text to be displayed.
#          $3 - [OPTIONAL] to control display of prompt to continue.
#                          null (Default) - "OK" button or text prompt, display until either Enter key or "OK" button is pressed.
#                          "OK"           - "OK" button or text prompt, display until either Enter key or "OK" button is pressed.
#                          "NOK"          - No "OK" button or text prompt, display for $3 seconds before continuing automatically.
#          $4 - [OPTIONAL] to control pause duration. Only used if $3="NOK".
#                          $4 seconds pause to allow text to be read before continuing automatically.
#          THIS_DIR, THIS_FILE, VERSION.
#    Uses: X.
# Outputs: None.
#
# Summary: Display lines of text beginning with a given comment delimiter.
#
# Dependencies: f_message.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
f_display_common_TEMPLATE () {
      #
      # Set $THIS_FILE to the file name containing the text to be displayed.
      #
      # WARNING: Do not define $THIS_FILE within a library script.
      #
      # This prevents $THIS_FILE being inadvertently re-defined and set to
      # the file name of the library when the command:
      # "source [ LIBRARY_FILE.lib ]" is used.
      #
      # For that reason, all library files now have the line
      # THIS_FILE="[LIBRARY_FILE.lib]" commented out or deleted.
      #
      #
      #==================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME
      # CONTAINING THE BRIEF DESCRIPTION, CODE HISTORY, AND HELP MESSAGE.
      #==================================================================
      #
      #
      THIS_FILE="cliappmenu.sh"  # <<<--- INSERT ACTUAL FILE NAME HERE.
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
      sed --silent "s/$2//p" $THIS_DIR/$THIS_FILE >> $TEMP_FILE
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
# +-----------------------------------------+
# | Function f_menu_main_all_menus          |
# +-----------------------------------------+
#
#     Rev: 2024-02-15
#  Inputs: $1 - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2 - MENU_TITLE Title of menu which must also match the header
#               and tail strings for the menu data in the ARRAY_SOURCE_FILE.
#              !!!Menu title MUST use underscores instead of spaces!!!
#          $3 - ARRAY_SOURCE_FILE is the file name where the menu data is stored.
#               This can be the run-time script or a separate *.lib library file.
#    Uses: ARRAY_SOURCE_FILE, ARRAY_TEMP_FILE, GENERATED_FILE, MENU_TITLE, TEMP_FILE.
# Outputs: None.
#
# Summary: Display any menu. Use this same function to display
#          both Main-Menu and any sub-menus. The Main Menu and all sub-menu data
#          may either be in the run-time script (*.sh) or a separate library (*.lib)
#
#          A single script/library file contains data for multiple menus
#          where there may be 1 or more menus within 1 file.
#
#          Simply state the Path/Filename of the library file, ARRAY_SOURCE_FILE
#          which contains the menu data.
#
# Dependencies: f_menu_arrays, f_create_show_menu.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO THE MAIN SCRIPT WHICH WILL CALL IT.
#
f_menu_main_all_menus () {
      #
      #
      if [ "$1" = "text" ] ; then
         # Restore user-selected CLI colors to terminal. Not applicable for "Dialog" or "Whiptail".
         # Why needed? Function f_message uses application "Less" to display pages of text.
         # But "Less" resets the terminal's colors to white on black.
         f_configure_use $1
      fi
      #
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $ARRAY_SOURCE_FILE AS THE ACTUAL FILE NAME
      # WHERE THE MENU ITEM DATA IS LOCATED. THE LINES OF DATA ARE PREFIXED BY "#@@".
      #================================================================================
      #
      #
      # Note: Alternate menu data storage scheme.
      # For a separate library file for each menu data (1 menu/1 library file),
      # or for the run-time program to contain the Main Menu data (1 Main menu/run-time script),
      # then see f_menu_main_TEMPLATE in common_bash_function.lib
      #
      # Specify the library file name with menu item data.
      # ARRAY_SOURCE_FILE (Not a temporay file) includes menu items
      # from one or more menus (multiple menus/1 library file ARRAY_SOURCE_FILE).
      ARRAY_SOURCE_FILE=$3
      #
      #
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE MENU_TITLE AS THE ACTUAL TITLE OF THE MENU THAT
      # CONTAINS THE MENU ITEM DATA. THE LINES OF DATA ARE PREFIXED BY "#@@".
      #================================================================================
      #
      #
      # Note: ***If Menu title contains spaces,
      #       ***the size of the menu window will be too narrow.
      #
      # Menu title MUST use underscores instead of spaces.
      MENU_TITLE=$2
      #
      # Examples of valid $2 parameters:
      # MENU_TITLE="Main_Menu"
      # MENU_TITLE="Task_Menu"
      # MENU_TITLE="Utility_Menu"
      #
      # The MENU_TITLE must match the strings in the ARRAY_SOURCE_FILE.
      #
      #  Example:
      #   The run-time script file, "ice_cream.sh" may also contain the data
      #   for both Main menu and sub-menus.
      #
      #     MENU_TITLE="All_Ice_Cream_Menu"
      #     ARRAY_SOURCE_FILE="ice_cream.sh"
      #
      #   If you have a lot of menus, you may want to have all the menu data
      #   for both Main menu and sub-menus in a separate library file,
      #   "all_ice_cream_menus.lib".
      #
      #     MENU_TITLE="All_Ice_Cream_Menu"
      #     ARRAY_SOURCE_FILE="all_ice_cream_menus.lib"
      #
      # Format for $ARRAY_SOURCE_FILE: ("ice_cream.sh" or "all_ice_cream_menus.lib")
      #
      #  Listing of $ARRAY_SOURCE_FILE ("ice_cream.sh" or "all_ice_cream_menus.lib")
      #          which includes menu item data:
      #
      #  Start Listing Tasty Ice Cream Menu (Required header, do not delete).
      #      Data for Menu item 1
      #      Data for Menu item 2
      #      Data for Menu item 3
      #  End Listing Tasty Ice Cream Menu (Required line, do not delete).
      #
      #  Start Listing Ice Cream Toppings Menu (Required header, do not delete).
      #      Data for Menu item 1
      #      Data for Menu item 2
      #      Data for Menu item 3
      #  End Listing Ice Cream Toppings Menu (Required line, do not delete).
      #
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_menu_temp.txt"
      #
      # GENERATED_FILE (The name of a temporary library file which contains the code to display the sub-menu).
      GENERATED_FILE=$THIS_DIR/$THIS_FILE"_menu_generated.lib"
      #
      # ARRAY_TEMP_FILE (Temporary file) includes menu items imported from $ARRAY_SOURCE_FILE of a single menu.
      ARRAY_TEMP_FILE=$THIS_DIR/$THIS_FILE"_menu_array_generated.lib"
      #
      # ARRAY_FILE is used by f_update_menu_gui and f_update_menu_txt.
      # It is not included in formal passed parameters but is used anyways
      # in the $GENERATED_FILE as a line: "source $ARRAY_FILE".
      # I wanted to retire this variable name, but it has existed in the
      # common_bash_function.lib library for quite a while.
      ARRAY_FILE=$GENERATED_FILE
      #
      # When using f_create_a_menu, all subsequent sub-menus do not need a separate
      # hard-coded function, since f_create_a_menu will generate sub-menu functions as needed.
      #
      # List of inputs for f_create_a_menu.
      #
      #  Inputs: $1 - "text", "dialog" or "whiptail" The command-line user-interface application in use.
      #          $2 - GENERATED_FILE (The name of a temporary library file containing the suggested phrase "generated.lib" which contains the code to display the sub-menu).
      #          $3 - MENU_TITLE (Title of the sub-menu)
      #          $4 - TEMP_FILE (Temporary file).
      #          $5 - ARRAY_TEMP_FILE (Temporary file) includes menu items imported from $ARRAY_SOURCE_FILE of a single menu.
      #          $6 - ARRAY_SOURCE_FILE (Not a temporary file) includes menu items from multiple menus.
      #
      f_create_a_menu $1 $GENERATED_FILE $MENU_TITLE $TEMP_FILE $ARRAY_TEMP_FILE $ARRAY_SOURCE_FILE
      #
      if [ -e $TEMP_FILE ] ; then
         rm $TEMP_FILE
      fi
      #
      if [ -e  $GENERATED_FILE ] ; then
         rm  $GENERATED_FILE
      fi
      #
} # End of function f_menu_main_all_menus.
#
# +----------------------------------------+
# |  Function fdl_dwnld_file_from_web_site |
# +----------------------------------------+
#
#     Rev: 2024-02-25
#  Inputs: $1 - GitHub Repository
#          $2 - file name to download.
#    Uses: None.
# Outputs: None.
#
# Summary: Download a list of file names from a web site.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: wget.
#
#
fdl_dwnld_file_from_web_site () {
      #
      # $1 ends with a slash "/" so can append $2 immediately after $1.
      wget --show-progress $1$2
      ERROR=$?
      #
      # Make downloaded file executable.
      chmod 755 $2
      #
      # Move all files to sub-directory /home/[user]/cliapp-dir except those below.
      if [ -e $2 ] && [ $2 != "cliappmenu.sh" ] && [ $2 != "cliappmenu.lib" ] && [ $2 != "common_bash_function.lib" ] ; then
         mv $2 $CLI_DIR
      fi
      #
      if [ $ERROR -ne 0 ] ; then
            echo
            echo ">>>>>>>>>>>>>><<<<<<<<<<<<<<"
            echo ">>> wget download failed <<<"
            echo ">>>>>>>>>>>>>><<<<<<<<<<<<<<"
            echo
            echo "Error copying file: \"$2.\""
            echo
            echo "from GitHub Repository:"
            echo "$WEB_REPOSITORY_URL"
            echo
            echo -e "Warning: If the Github Repository is \"Private\","
            echo "         then anonymous downloads are not permitted."
            echo
            echo ">>>>>>>>>>>>>><<<<<<<<<<<<<<"
            echo
      fi
      #
} # End of function fdl_dwnld_file_from_web_site.
#
# +-----------------------------------------------+
# | Function fdl_dwnld_file_from_local_repository |
# +-----------------------------------------------+
#
#     Rev: 2024-02-25
#  Inputs: $1 - Local Repository Directory.
#          $2 - File to download.
#    Uses: TEMP_FILE.
# Outputs: ERROR.
#
# Summary: Copy a file from the local repository on the LAN file server.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: None.
#
fdl_dwnld_file_from_local_repository () {
      #
      eval cp -p $1/$2 .
      ERROR=$?
      #
      # Make downloaded file executable.
      chmod 755 $2
      #
      # Move all files to sub-directory /home/[user]/cliapp-dir except those below.
      if [ -e $2 ] && [ $2 != "cliappmenu.sh" ] && [ $2 != "cliappmenu.lib" ] && [ $2 != "common_bash_function.lib" ] ; then
         mv $2 $CLI_DIR
      fi
      #
      if [ $ERROR -ne 0 ] ; then
         echo
         echo ">>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<"
         echo ">>> File Copy Error from Local Repository <<<"
         echo ">>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<"
         echo
         echo -e "Error copying file: \"$2.\""
         echo
         echo "from Local Repository:"
         echo "$LOCAL_REPO_DIR"
         echo
         echo ">>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<"
         echo
         ERROR=1
      fi
      #
      if [ $ERROR -eq 0 ] ; then
         echo
         echo -e "Successful Update of file \"$2\" to latest version.\n\nScript must be re-started to use the latest version."
         echo "____________________________________________________"
      fi
      #
} # End of function fdl_dwnld_file_from_local_repository.
#
# +-------------------------------------+
# |       Function fdl_mount_local      |
# +-------------------------------------+
#
#     Rev: 2024-02-25
#  Inputs: $1 - Server Directory.
#          $2 - Local Mount Point Directory
#          TEMP_FILE
#    Uses: TARGET_DIR, UPDATE_FILE, ERROR, SMBUSER, PASSWORD.
# Outputs: QUIT, ERROR.
#
# Summary: Mount directory using Samba and CIFS and echo error message.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: Software package "cifs-utils" in the Distro's Repository.
#
fdl_mount_local () {
      #
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
      #
      # Get status of mountpoint, mounted? Do not display status.
      mountpoint $2 >/dev/null
      ERROR=$?
      if [ $ERROR -eq 0 ] ; then
         # Directory is already mounted.
         # Outputs ERROR=0.
         # Quit loop.
         QUIT=1
      else
         # Mount failed, Do you want to try again?
         DEFAULT_ANS="Y"
         QUES_STR="Failed to mount\n\nShare-point:\n$1\n\nonto\n\nMount-point:\n$2\n\nTry another password to mount $1?"
         #
         clear  # Blank screen.
         #
         # Does $QUES_STR contain "\n"?  Does the string $QUES_STR contain multiple sentences?
         case $QUES_STR in
              *\n*)
                 # Yes, string $QUES_STR contains multiple sentences.
                 #
                 # Command-Line interface (CLI) does not have option "--colors" with "\Z" commands for font color bold/normal.
                 # Use command "sed" with "-e" to filter out multiple "\Z" commands.
                 # Filter out "\Z[0-7]", "\Zb", \ZB", "\Zr", "\ZR", "\Zu", "\ZU", "\Zn".
                 ZNO=$(echo $QUES_STR | sed -e 's|\\Z0||g' -e 's|\\Z1||g' -e 's|\\Z2||g' -e 's|\\Z3||g' -e 's|\\Z4||g' -e 's|\\Z5||g' -e 's|\\Z6||g' -e 's|\\Z7||g' -e 's|\\Zb||g' -e 's|\\ZB||g' -e 's|\\Zr||g' -e 's|\\ZR||g' -e 's|\\Zu||g' -e 's|\\ZU||g' -e 's|\\Zn||g')
                 TEXT_STR="$ZNO"
              ;;
              *)
                 # No, string $QUES_STR contains a single sentence.
                 #
                 # Create a text file from the string.
                 TEXT_STR="$QUES_STR"
              ;;
         esac
         #
         case $DEFAULT_ANS in
              [Yy] | [Yy][Ee][Ss])
                 # "Yes" is the default answer.
                 echo -e -n "$TEXT_STR (Y/n) "; read ANS # < /dev/tty
                 #
                 case $ANS in
                      [Nn] | [Nn][Oo])
                         ANS=1  # No.
                      ;;
                      *)
                         ANS=0  # Yes (Default).
                      ;;
                 esac
              ;;
              [Nn] | [Nn][Oo])
                 # "No" is the default answer.
                 echo -e -n "$TEXT_STR (y/N) "; read ANS # < /dev/tty
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                         ANS=0  # Yes.
                      ;;
                      *)
                         ANS=1  # No (Default).
                      ;;
                 esac
              ;;
         esac
         #
         # Outputs user response to $ANS.
         # Try another password to mount $1?"
         if [ $ANS -eq 0 ] ; then
            # Yes, try another SMB username and password to mount Share-point.
            QUIT=0
            # Try again to mount.
            # Set the default username to the SMB username entered previously.
            #
            # Cannot use any user prompted read answers if this function is in a loop where file is a loop input.
            # The read statements will be treated as the next null parameters in the loop without user input.
            # To solve this problem, specify input from /dev/tty "the keyboard".
            #
            echo
            echo "Mounting share-point $1 onto local mount-point $2"
            echo
            read -p "Enter user name: " SMBUSER < /dev/tty
            echo
            read -s -p "Enter Password: " PASSWORD < /dev/tty
            echo sudo mount -t cifs $1 $2
            sudo mount -t cifs -o username="$SMBUSER" -o password="$PASSWORD" $1 $2
            unset SMBUSER PASSWORD
            #
            # Write any error messages to file $TEMP_FILE. Get status of mountpoint, mounted?.
            mountpoint $2 >/dev/null 2>$TEMP_FILE
            ERROR=$?
            #
            if [ $ERROR -eq 0 ] ; then
               # Successful mounting of share-point $1 onto local mount-point $2.
               # Outputs ERROR=0.
               QUIT=1
            else
               # Failed to mount share-point $1 onto local mount-point $2.
               # Outputs ERROR=1.
               QUIT=0
            fi
         else
            # No, do not try another password just return to previous menu. Exit loop.
            # Quit f_mount loop, return to previous menu.
            # Outputs ERROR=1.
            QUIT=1
         fi
      fi
      #
      if [ -e  $TEMP_FILE ] ; then
         rm  $TEMP_FILE
      fi
      #
} # End of function fdl_mount_local.
#
# +------------------------------------+
# |        Function fdl_source         |
# +------------------------------------+
#
#     Rev: 2022-10-10
#  Inputs: $1 - File name to source.
# Outputs: ERROR.
#
# Summary: Source the provided library file and echo error message.
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: None.
#
fdl_source () {
      #
      # Initialize ERROR.
      ERROR=0
      #
      if [ -x "$1" ] ; then
         # If $1 is a library, then source it.
         case $1 in
              *.lib)
                 source $1
                 ERROR=$?
                 #
                 if [ $ERROR -ne 0 ] ; then
                    echo
                    echo ">>>>>>>>>><<<<<<<<<<<"
                    echo ">>> Library Error <<<"
                    echo ">>>>>>>>>><<<<<<<<<<<"
                    echo
                    echo -e "$1 cannot be sourced using command:\n\"source $1\""
                    echo
                 fi
              ;;
         esac
         #
      fi
      #
} # End of function fdl_source.
#
# +----------------------------------------+
# |  Function fdl_download_missing_scripts |
# +----------------------------------------+
#
#     Rev: 2024-02-21
#  Inputs: $1 - File containing a list of all file dependencies.
#          $2 - File name of generated list of missing file dependencies.
# Outputs: ANS.
#
# Summary: This function can be used when script is first run.
#          It verifies that all dependencies are satisfied.
#          If any are missing, then any missing required dependencies of
#          scripts and libraries are downloaded from a LAN repository or
#          from a repository on the Internet.
#
#          This function allows this single script to be copied to any
#          directory and then when it is executed or run, it will download
#          automatically all other needed files and libraries, set them to be
#          executable, and source the required libraries.
#
#          Cannot be dependent on "common_bash_function.lib" as this library
#          may not yet be available and may need to be downloaded.
#
# Dependencies: None.
#
fdl_download_missing_scripts () {
      #
      # Initialize variables.
      #
      TEMP_FILE=$THIS_FILE"_temp.txt"
      #
      # Delete any existing temp file.
      if [ -r  $2 ] ; then
         rm  $2
      fi
      #
      # ****************************************************
      # Create new list of files that need to be downloaded.
      # ****************************************************
      #
      # While-loop will read the file names listed in FILE_LIST ($1 list of
      # script and library files) and detect which are missing and need
      # to be downloaded and then put those file names in FILE_DL_LIST ($2).
      #
      #
      # Download files from Local Repository or Web GitHub Repository
      # or extract files from the compressed file "cli-app-menu-new-main.zip"
      # which may be downloaded from the repository on the Github.com website.
      #
      while read LINE
            do
               ERROR=0
               #
               FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
               #
               # Does file belong in the home directory?
               if [ $FILE != "cliappmenu.sh" ] && [ $FILE != "cliappmenu.lib" ] && [ $FILE != "common_bash_function.lib" ] ; then
                  # No, it belongs in $CLI_DIR sub-directory.
                  if [ ! -e $CLI_DIR/$FILE ] ; then
                     # File needs to be downloaded.
                     ERROR=1
                  fi
               else
                  # Yes, file belongs in home directory.
                  if [ ! -e $FILE ] ; then
                     # File needs to be downloaded.
                     ERROR=1
                  fi
               fi
               #
               if [ $ERROR -ne 0 ] ; then
                  # File needs to be downloaded. Add file name to a file list in a text file.
                  # Build list of files to download.
                  #
                  # An archive file .zip can be downloaded from the GitHub
                  # Repository.
                  # Does the zip file exist?
                  if [ -e cli-app-menu-new-main.zip ] ; then
                     # Yes, unzip and copy to the $CLI_DIR directory (usually ~/cliapp-dir).
                     unzip cli-app-menu-new-main.zip
                     rm --recursive $CLI_DIR
                     mv cli-app-menu-new-main $CLI_DIR
                     chmod -R 755 $CLI_DIR
                     # Move files that are required to be in the user's home directory.
                     mv $CLI_DIR/common_bash_function.lib $CLI_DIR/cliappmenu.lib .
                     #
                     #
                     #
                     #================================================================================
                     # EDIT THE LINE BELOW OF THE ZIP FILE OF THE LATEST GITHUB PROJECT RELEASE.
                     # THIS ZIP FILE IS DOWNLOADED FROM GITHUB.COM FROM THE PROJECT WEB PAGE FOR THE
                     # LATEST RELEASE OF THIS PROJECT. This zip file name will change whenever the
                     # latest release number is incremented when there is a new release.
                     #================================================================================
                     #
                     #
                  elif [ -e cli-app-menu-new-6.1.zip ] ; then
                     # Yes, unzip and copy to the $CLI_DIR directory (usually ~/cliapp-dir).
                     unzip cli-app-menu-new-6.1.zip
                     rm --recursive $CLI_DIR
                     mv cli-app-menu-new-6.1 $CLI_DIR
                     chmod -R 755 $CLI_DIR
                     # Move files that are required to be in the user's home directory.
                     mv $CLI_DIR/common_bash_function.lib $CLI_DIR/cliappmenu.lib .
                  else
                     # No, zip file is missing so add file name to download list.
                     echo $LINE >> $2
                  fi
               fi
            done < $1
      #
      # If there are files to download (listed in FILE_DL_LIST), then mount local repository.
      if [ -s "$2" ] ; then
         echo
         echo "There are missing file dependencies which must be downloaded from"
         echo "the local repository or web repository."
         echo
         echo "Missing files:"
         while read LINE
               do
                  echo $LINE | awk -F "^" '{ print $1 }'
               done < $2
         echo
         echo "You may need to present credentials, unless anonymous downloads are permitted."
         echo
         echo -n "Press '"Enter"' key to continue." ; read X ; unset X
         #
         #----------------------------------------------------------------------------------------------
         # From list of files to download created above $FILE_DL_LIST, download the files one at a time.
         #----------------------------------------------------------------------------------------------
         #
         # Downloaded the list of files $DL_FILE from the Local Repository?
         grep Local^ $2 >/dev/null
         ERROR=$?
         #
         # Initialize for while-loop.
         QUIT=0
         #
         # Are any of the missing files to be downloaded from the Local Repository?
         if [ $ERROR -eq 0 ] ; then
            # Yes, there are files to be downloaded from the Local Repository.
            #
            # Are LAN File Server directories available on Local Mount-point?
             while [ $QUIT -ne 1 ]  # Start loop.
                   do
                     fdl_mount_local $SERVER_DIR $MP_DIR
                   done
         fi
         #
         while read LINE
               do
                  # Get Download Source for each file.
                  DL_FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
                  DL_SOURCE=$(echo $LINE | awk -F "^" '{ print $2 }')
                  TARGET_DIR=$(echo $LINE | awk -F "^" '{ print $3 }')
                  DL_REPOSITORY=$(echo $LINE | awk -F "^" '{ print $4 }')
                  #
                  # Initialize Error Flag.
                  ERROR=0
                  #
                  # If a file which only exists in the Local Repository has
                  # its source changed to "Web" because LAN connectivity has
                  # failed, then do not download since the file is not in a
                  # GitHub.com Repository.
                  if [ -z $DL_REPOSITORY ] && [ $DL_SOURCE = "Web" ] ; then
                     ERROR=1
                  fi
                  case $DL_SOURCE in
                       Local)
                          # Download from Local Repository on LAN File Server.
                          #
                          if [ $ERROR -ne 0 ] ; then
                             # Failed to mount LAN File Server directory on Local Mount-point.
                             # So download from Web Repository.
                             fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                          else
                             # Sucessful mount of LAN File Server directory.
                             # Continue with download from Local Repository on LAN File Server.
                             fdl_dwnld_file_from_local_repository $TARGET_DIR $DL_FILE
                             #
                             if [ $ERROR -ne 0 ] ; then
                                # Failed to download from Local Repository on LAN File Server.
                                # So download from Web Repository.
                                fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                             fi
                          fi
                       ;;
                       Web)
                          # Download from Web Repository.
                          fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                          if [ $ERROR -ne 0 ] && [ $LOCAL_REPO_CRED_FAIL -eq 0 ] ; then
                             # Failed to download from Web Repository.
                             # So download from Local Repository.
                             # Try to mount LAN File Server directory on Local Mount-point.
                             fdl_mount_local $SERVER_DIR $MP_DIR
                             #
                             if [ $ERROR -eq 0 ] ; then
                                # Successful mount of LAN File Server directory.
                                # Continue with download from Local Repository on LAN File Server.
                                fdl_dwnld_file_from_local_repository $TARGET_DIR $DL_FILE
                             fi
                          fi
                       ;;
                  esac
               done < $2
         #
         if [ $ERROR -ne 0 ] ; then
            echo
            echo
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo ">>> Download failed. Cannot continue, exiting program. <<<"
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo
         else
            echo
            echo
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo ">>> Download is good. Re-run required, exiting program. <<<"
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            echo
         fi
         #
      fi
      #
      # Source each library.
      #
      while read LINE
            do
               FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
               # Invoke any library files.
               fdl_source $FILE
               if [ $ERROR -ne 0 ] ; then
                  echo
                  echo ">>>>>>>>>><<<<<<<<<<<"
                  echo ">>> Library Error <<<"
                  echo ">>>>>>>>>><<<<<<<<<<<"
                  echo
                  echo -e "$1 cannot be sourced using command:\n\"source $1\""
                  echo
               fi
            done < $1
      if [ $ERROR -ne 0 ] ; then
         echo
         echo
         echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
         echo ">>> Invoking Libraries failed. Cannot continue, exiting program. <<<"
         echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
         echo
      fi
      #
} # End of function fdl_download_missing_scripts.
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
#-------------------------------------------------------
# Detect and download any missing scripts and libraries.
#-------------------------------------------------------
#
#----------------------------------------------------------------
# Variables FILE_LIST and FILE_DL_LIST are defined in the section
# "Default Variable Values" at the beginning of this script.
#----------------------------------------------------------------
#
# Are any files/libraries missing?
fdl_download_missing_scripts $FILE_LIST $FILE_DL_LIST
#
# Are there any problems with the download/copy of missing scripts?
if [ -r  $FILE_DL_LIST ] || [ $ERROR -ne 0 ] ; then
   # Yes, there were missing files or download/copy problems so exit program.
   #
   # Delete temporary files.
   if [ -e $TEMP_FILE ] ; then
      rm $TEMP_FILE
   fi
   #
   if [ -r  $FILE_LIST ] ; then
      rm  $FILE_LIST
   fi
   #
   if [ -r  $FILE_DL_LIST ] ; then
      rm  $FILE_DL_LIST
   fi
   #
   exit 0  # This cleanly closes the process generated by #!bin/bash.
           # Otherwise every time this script is run, another instance of
           # process /bin/bash is created using up resources.
fi
#
# Remove FILE_LIST since already checked for missing files/libraries.
if [ -r  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
#***************************************************************
# Process Any Optional Arguments and Set Variables THIS_DIR, GUI
#***************************************************************
#
# Set THIS_DIR, SCRIPT_PATH to directory path of script.
f_script_path
#
# Set Temporary file using $THIS_DIR from f_script_path.
TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
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
# If command already specifies $GUI, then do not detect UI, but verify that
# it is an installed and valid UI.
# i.e. "bash menu.sh dialog" or "bash menu.sh text".
# Test for Optional Arguments.
# Also sets variable GUI.
f_arguments $1 $2
#
#
# Manual Override of UI Environment for testing purposes.
#GUI="whiptail"  # Diagnostic line.
#GUI="dialog"    # Diagnostic line.
#GUI="text"      # Diagnostic line.
#
# Delete temporary files.
if [ -r  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
if [ -r  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
#
# Test for X-Windows environment. Cannot run in CLI for LibreOffice.
# if [ x$DISPLAY = x ] ; then
#    f_message text "OK" "\Z1\ZbCannot run LibreOffice without an X-Windows environment.\ni.e. LibreOffice must run in a terminal emulator in an X-Window.\Zn"
# fi
#
# Test for BASH environment.
f_test_environment $GUI
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
#***************
# Run Main Code.
#***************
#
#  Inputs for f_menu_main_all_menus
#
#  Inputs: $1 - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2 - MENU_TITLE Title of menu which must also match the header
#               and tail strings for the menu data in the ARRAY_SOURCE_FILE.
#              !!!Menu title MUST use underscores instead of spaces!!!
#          $3 - ARRAY_SOURCE_FILE is the file name where the menu data is stored.
#               This can be the run-time script or a separate *.lib library file.
#
f_menu_main_all_menus $GUI CLI_Action_Menu $THIS_DIR/cliappmenu.lib
#
# Delete temporary files.
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
if [ -e  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
if [ -e  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
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
