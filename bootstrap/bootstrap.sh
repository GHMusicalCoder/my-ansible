#!/usr/bin/env bash
LC_ALL=C

##########################################################################
## BASE CONFIGURATIONS
##########################################################################
function messenger() {
    if [ -z "${1}" ] || [ -z "${2}" ]; then
        return
    fi

    local RED="\e[31m"
    local GREEN="\e[32m"
    local YELLOW="\e[33m"
    local BLUE="\e[34m"
    local MAGENTA="\e[35m"
    local CYAN="\e[36m"
    local RESET="\e[0m"
    local MTYPE="${1}"
    local MSG="${2}"

    case ${MTYPE} in
        info) echo -e " [${GREEN}+${RESET}] ${BLUE}${MSG}${RESET}";;
        progress) echo -e " [${GREEN}+${RESET}] ${CYAN}${MSG}${RESET}";;
        recommend) echo -e " [${MAGENTA}!${RESET}] ${MAGENTA}${MSG}${RESET}";;
        warn) echo -e " [${YELLOW}*${RESET}] ${YELLOW}WARNING! ${MSG}${RESET}";;
        error) echo -e " [${RED}!${RESET}] ${RED}ERROR! ${MSG}${RESET}";;
        fatal) echo -e " [${RED}!${RESET}] ${RED}ERROR! ${MSG}${RESET}"
                exit 1;;
        *) echo -e " [?] UNKNOWN: ${MSG}";;
    esac
}

messenger progress "Setting up config variables"
PLAYBOOK="install.yaml"
SUDO="$(which sudo)"
APT="$(which apt)"
RM="$(which rm)"
WORK_DIR="/tmp"
REPO="${WORK_DIR}/my-ansible"
URL="https://github.com/GHMusicalCoder/my-ansible.git"


