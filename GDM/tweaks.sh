#! /usr/bin/env bash

# WARNING: Please make this shell not working-directory dependant, for example
# instead of using 'ls blabla', use 'ls "${REPO_DIR}/blabla"'
#
# WARNING: Don't use "cd" in this shell, use it in a subshell instead,
# for example ( cd blabla && do_blabla ) or $( cd .. && do_blabla )
#
# SUGGESTION: Please don't put any dependency installation here

###############################################################################
#                             VARIABLES & HELP                                #
###############################################################################

readonly REPO_DIR="$(dirname "$(readlink -m "${0}")")"
source "${REPO_DIR}/libs/lib-install.sh"

# Customization, default values
colors=("${COLOR_VARIANTS[@]}")
opacities=("${OPACITY_VARIANTS[@]}")

# Firefox values
adaptive=''
theme_name="$THEME_NAME"
firefoxtheme="$THEME_NAME"

usage() {
  # Please specify their default value manually, some of them are come from _variables.scss
  # You also have to check and update them regurally
  helpify_title

  helpify "" "" "Tweaks for GDM theme" "options"
  sec_title "-g, --gdm"                    ""                                                  "  Without options default GDM theme will install..."                ""
  sec_helpify "1. -i, -icon"               "[$(IFS='|'; echo "${ICON_VARIANTS[*]}")]"          "  Set GDM panel 'Activities' icon"                                  "Default is 'standard'"
  sec_helpify "2. -b, -background"         "[default|blank|IMAGE_PATH]"                        "  Set GDM background image"                                         "Default is MacOS wallpaper"
  sec_helpify "3. -p, -panelopacity"       "[$(IFS='|'; echo "${PANEL_OPACITY_VARIANTS[*]}")]" "  Set GDM panel transparency"                                       "Default is 15%"
  sec_helpify "4. -h, -panelheight"        "[$(IFS='|'; echo "${PANEL_SIZE_VARIANTS[*]}")]"    "  Set GDM panel height size"                                        "Default is 32px"
  sec_helpify "5. -sf, -smallerfont"       ""                                                  "  Set GDM font size to smaller (10pt)"                              "Default is 11pt"
  sec_helpify "6. -nd, -nodarken"          ""                                                  "  Don't darken '${THEME_NAME}' GDM theme background image"          ""
  sec_helpify "7. -nb, -noblur"            ""                                                  "  Don't blur '${THEME_NAME}' GDM theme background image"            ""
  sec_helpify "8.  -o, --opacity"          "[$(IFS='|'; echo "${OPACITY_VARIANTS[*]}")]"       "  Set '${THEME_NAME}' GDM theme opacity variants"                   "Default is 'normal'"
  sec_helpify "9.  -c, --color"            "[$(IFS='|'; echo "${COLOR_VARIANTS[*]}")]"         "  Set '${THEME_NAME}' GDM theme color variants"                     "Default is 'dark'"
  sec_helpify "10. -t, --theme"            "[$(IFS='|'; echo "${THEME_VARIANTS[*]}")]"         "  Set '${THEME_NAME}' GDM theme accent color"                       "Default is 'blue'"
  sec_helpify "11. -s, --scheme"           "[$(IFS='|'; echo "${SCHEME_VARIANTS[*]}")]"        "  Set '${THEME_NAME}' GDM theme colorscheme style"                  "Default is 'standard'"

  helpify "" "" "Tweaks for firefox" "options"
  sec_title "-f, --firefox" "        [default|adaptive]"                            "  Without options default theme will install..."                               "  Options:"
  sec_helpify "1. default"  "      default version"                                 ""                                                                              ""
  sec_helpify "2. adaptive" "      Adaptive color version"                          "  You need install adaptive-tab-bar-colour plugin first"                       "  https://addons.mozilla.org/firefox/addon/adaptive-tab-bar-colour/"

  helpify "-e, --edit-firefox"  "[default|adaptive]"                                "  Edit '${THEME_NAME}' theme for Firefox settings and also connect the theme to the current Firefox profiles" ""

  helpify "" "" "Others" "options"
  sec_title "-F, --flatpak"     "Support options: [-o, -c, -t...]"                             "  Connect '${THEME_NAME}' theme to Flatpak"                         "Without options will only install default themes"
  sec_helpify "1.  -o, --opacity"          "[$(IFS='|'; echo "${OPACITY_VARIANTS[*]}")]"       "  Set '${THEME_NAME}' flatpak theme opacity variants"               "Default is 'normal'"
  sec_helpify "2.  -c, --color"            "[$(IFS='|'; echo "${COLOR_VARIANTS[*]}")]"         "  Set '${THEME_NAME}' flatpak theme color variants"                 "Default is 'light'"
  sec_helpify "3.  -t, --theme"            "[$(IFS='|'; echo "${THEME_VARIANTS[*]}")]"         "  Set '${THEME_NAME}' flatpak theme accent color"                   "Default is 'blue'"
  sec_helpify "4.  -s, --scheme"           "[$(IFS='|'; echo "${SCHEME_VARIANTS[*]}")]"        "  Set '${THEME_NAME}' flatpak theme colorscheme style"              "Default is 'standard'"

  helpify "-d, --dash-to-dock"  ""                                                  "  Fixed Dash to Dock theme issue"                                              ""

  helpify "-r, --remove, --revert" ""                                               "  Revert to the original themes, do the opposite things of install and connect" ""
  helpify "--silent-mode"       ""                                                  "  Meant for developers: ignore any confirm prompt and params become more strict" ""
  helpify "-h, --help"          ""                                                  "  Show this help"                                                              ""
}

gdm_info() {
  if [[ "${gdm}" == "false" ]]; then
    prompt -e "Oops... there's nothing to tweak. this option '${1}' only works for GDM theme! ..."
    prompt -i "HINT: Run ./tweaks.sh -h for help!... \n"
  fi
}

###############################################################################
#                                  MAIN                                       #
###############################################################################

#-----------------------------PARSE ARGUMENTS---------------------------------#

echo

while [[ $# -gt 0 ]]; do
  # Don't show any dialog here. Let this loop checks for errors or shows help
  # We can only show dialogs when there's no error and no -r parameter
  #
  # * shift for parameters that have no value
  # * shift 2 for parameter that have a value
  #
  # Please don't exit any error here if possible. Let it show all error warnings
  # at once

  case "${1}" in
      # Parameters that don't require value
    -r|--remove|--revert)
      uninstall='true'; shift ;;
    --silent-mode)
      full_sudo "${1}"; silent_mode='true'; shift ;;
    -h|--help)
      need_help="true"; shift ;;
    -f|--firefox|-e|--edit-firefox)
      case "${1}" in
        -f|--firefox)
          firefox="true" ;;
        -e|--edit-firefox)
          edit_firefox="true" ;;
      esac

      for variant in "${@}"; do
        case "${variant}" in
          default)
            firefoxtheme="MacTahoe"
            shift ;;
          adaptive)
            adaptive="-adaptive"
            prompt -i "Firefox adaptive color version...\n"
            prompt -w "You need install adaptive-tab-bar-colour plugin first: https://addons.mozilla.org/firefox/addon/adaptive-tab-bar-colour/\n"
            shift ;;
        esac
      done

      if ! has_command firefox && ! has_command firefox-bin && ! has_flatpak_app org.mozilla.firefox && ! has_snap_app firefox && ! has_command firefox-developer-edition; then
        prompt -e "'${1}' ERROR: There's no Firefox installed in your system"
        has_any_error="true"
      elif [[ ! -d "${FIREFOX_DIR_HOME}" && ! -d "${FIREFOX_FLATPAK_DIR_HOME}" && ! -d "${FIREFOX_SNAP_DIR_HOME}" ]]; then
        prompt -e "'${1}' ERROR: Firefox is installed but not yet initialized."
        prompt -w "'${1}': Don't forget to close it after you run/initialize it"
        has_any_error="true"
      elif pidof "firefox" &> /dev/null || pidof "firefox-bin" &> /dev/null; then
        prompt -e "'${1}' ERROR: Firefox is running, please close it"
        has_any_error="true"
      fi; shift ;;
    -g|--gdm)
      gdm="true"; full_sudo "${1}"
      showapps_normal="true" # use normal showapps icon
      background="default"
      shift
      for variant in "${@}"; do
        case "${variant}" in
          -i|-icon)
            activities_icon="true";
            check_param "${1}" "${1}" "${2}" "must" "must" "must" && shift 2 || shift ;;
          -b|-background)
            check_param "${1}" "${1}" "${2}" "must" "must" "must" "false" && shift 2 || shift ;;
          -p|-panelopacity)
            check_param "${1}" "${1}" "${2}" "optional" "optional" "optional" && shift 2 || shift ;;
          -h|-panelheight)
            check_param "${1}" "${1}" "${2}" "optional" "optional" "optional" && shift 2 || shift ;;
          -nd|-nodarken)
            gdm_info ${1}
            no_darken="true"; shift ;;
          -nb|-noblur)
            gdm_info ${1}
            no_blur="true"; shift ;;
          -sf|-smallerfont)
            smaller_font="true"; shift ;;
        esac
      done

      if ! has_command gdm && ! has_command gdm3 && [[ ! -e /usr/sbin/gdm3 ]]; then
        prompt -e "'${1}' ERROR: There's no GDM installed in your system"
        has_any_error="true"
      fi ;;
    -F|--flatpak)
      flatpak="true"; signal_exit

      if ! has_command flatpak; then
        prompt -e "'${1}' ERROR: There's no Flatpak installed in your system"
        has_any_error="true"
      fi; shift ;;
    -d|--dash-to-dock)
      if [[ ! -d "${DASH_TO_DOCK_DIR_HOME}" && ! -d "${DASH_TO_DOCK_DIR_ROOT}" ]]; then
        prompt -e "'${1}' ERROR: There's no Dash to Dock installed in your system"
        has_any_error="true"
      else
        dash_to_dock="true"
      fi; shift ;;
    -o|--opacity)
      check_param "${1}" "${1}" "${2}" "not-at-all" "must" "must" && shift 2 || shift ;;
    -c|--color)
      check_param "${1}" "${1}" "${2}" "not-at-all" "must" "must" && shift 2 || shift ;;
    -t|--theme)
      check_param "${1}" "${1}" "${2}" "not-at-all" "must" "must" && shift 2 || shift ;;
    -s|--scheme)
      check_param "${1}" "${1}" "${2}" "not-at-all" "must" "must" && shift 2 || shift ;;
    *)
      prompt -e "ERROR: Unrecognized tweak option '${1}'."
      has_any_error="true"; shift ;;
  esac
done

finalize_argument_parsing

#---------------------------START INSTALL THEMES-------------------------------#

if [[ "${uninstall}" == 'true' ]]; then
  prompt -w "REMOVAL: Non file-related parameters will be ignored. \n"

  if [[ "${gdm}" == 'true' ]]; then
    if [[ "${firefox}" == 'true' || "${edit_firefox}" == 'true' || "${flatpak}" == 'true' || "${snap}" == 'true' || "${dash_to_dock}" == 'true' ]]; then
      prompt -e "Do not run this option with '--gdm' \n"
    else
      prompt -i "Removing '${name}' GDM theme... \n"
      revert_gdm_theme
      prompt -s "Done! '${name}' GDM theme has been removed. \n"
    fi
  fi

  if [[ "${flatpak}" == 'true' && "${gdm}" != 'true' ]]; then
    prompt -i "Disconnecting '${name}' theme from your Flatpak... \n"
    disconnect_flatpak
    prompt -s "Done! '${name}' theme has been disconnected from your Flatpak. \n"
  fi

  if [[ "${dash_to_dock}" == 'true' && "${gdm}" != 'true' ]]; then
    prompt -i "Revert Dash to Dock theme... \n"
    revert_dash_to_dock_theme
    prompt -s "Done! Dash to Dock theme has reverted to default. \n"
  fi

  if [[ "${firefox}" == 'true' && "${gdm}" != 'true' ]]; then
    prompt -i "Removing '${firefoxtheme}' Firefox theme... \n"
    remove_firefox_theme
    prompt -s "Done! '${firefoxtheme}' Firefox theme has been removed. \n"
  fi
else
  customize_theme

  if [[ "${gdm}" == 'true' ]]; then
    if [[ "${firefox}" == 'true' || "${edit_firefox}" == 'true' || "${flatpak}" == 'true' || "${snap}" == 'true' || "${dash_to_dock}" == 'true' ]]; then
      prompt -e "Do not run this option with '--gdm' \n"
    else
      prompt -i "Installing '${name}' GDM theme... \n"
      if [[ "$GNOME_VERSION" == '48-0' ]]; then
        install_only_gdm_theme
      else
        install_gdm_theme
      fi
      prompt -s "Done! '${name}' GDM theme has been installed. \n"
    fi
  fi

  if [[ "${flatpak}" == 'true' && "${gdm}" != 'true' ]]; then
    prompt -i "Connecting '${name}' themes to your Flatpak... \n"
    prompt -w "Without options it will only install default themes\n"
    customize_theme; avoid_variant_duplicates; connect_flatpak
    prompt -s "Done! '${name}' theme has been connected to your Flatpak. \n"
  fi

  if [[ "${dash_to_dock}" == 'true' && "${gdm}" != 'true' ]]; then
    prompt -i "Fix Dash to Dock theme issue... \n"
    fix_dash_to_dock
    prompt -s "Done! '${name}' Dash to Dock theme has been fixed. \n"
    prompt -w "DASH TO DOCK: You may need to logout to take effect. \n"
  fi

  if [[ "${firefox}" == 'true' || "${edit_firefox}" == 'true' ]]; then
    if [[ "${darker}" == '-darker' && "${adaptive}" == '-adaptive' ]]; then
      prompt -w "FIREFOX: You can't use 'adaptive' and 'darker' at the same time. \n"
      prompt -i "FIREFOX: Setting to adaptive only... \n"
      darker=''
    fi

    if [[ "${firefox}" == 'true' && "${gdm}" != 'true' ]]; then
      prompt -i "Installing '${firefoxtheme}' Firefox theme... \n"
      install_firefox_theme
      prompt -s "Done! '${firefoxtheme}' Firefox theme has been installed. \n"
    fi

    if [[ "${edit_firefox}" == 'true' && "${gdm}" != 'true' ]]; then
      prompt -i "Editing '${firefoxtheme}' Firefox theme preferences... \n"
      edit_firefox_theme_prefs
      prompt -s "Done! '${firefoxtheme}' Firefox theme preferences has been edited. \n"
    fi

    if [[ "${gdm}" == "false" ]]; then
      prompt -w "FIREFOX: Please go to [Firefox menu] > [Customize...], and customize your Firefox to make it work. Move your 'new tab' button to the titlebar instead of tab-switcher. \n"
      prompt -i "FIREFOX: Anyway, you can also edit 'userChrome.css' and 'customChrome.css' later in your Firefox profile directory. \n"
    fi
  fi
fi

if [[ "${firefox}" == "false" && "${edit_firefox}" == "false" && "${flatpak}" == "false" && "${gdm}" == "false" && "${dash_to_dock}" == "false" && "${libadwaita}" == "false" ]]; then
  prompt -e "Oops... there's nothing to tweak..."
  prompt -i "HINT: Don't forget to define which component to tweak, e.g. '--gdm'"
  prompt -i "HINT: Run ./tweaks.sh -h for help!... \n"
fi
