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
        info) echo -e " [${GREEN}#${RESET}] ${BLUE}${MSG}${RESET}";;
        progress) echo -e " [${GREEN}+${RESET}] ${CYAN}${MSG}${RESET}";;
        recommend) echo -e " [${MAGENTA}!${RESET}] ${MAGENTA}${MSG}${RESET}";;
        warn) echo -e " [${YELLOW}*${RESET}] ${YELLOW}WARNING! ${MSG}${RESET}";;
        error) echo -e " [${RED}!${RESET}] ${RED}ERROR! ${MSG}${RESET}";;
        fatal) echo -e " [${RED}!${RESET}] ${RED}ERROR! ${MSG}${RESET}"
                exit 1;;
        *) echo -e " [?] UNKNOWN: ${MSG}";;
    esac
}

messenger info "Setting up config variables"
HOME="/home/$USER"
PLAYBOOK="install.yaml"
SUDO="$(which sudo)"
APT="$(which apt)"
RM="$(which rm)"
WORK_DIR="${HOME}/Development"
REPO="${WORK_DIR}/my-ansible"
URL="https://github.com/GHMusicalCoder/my-ansible.git"
VAULT=".ansible_vault_key"

messenger progress "Installing installation dependencies via apt"
${SUDO} ${APT} update -qq
${SUDO} ${APT} upgrade -qq
${SUDO} ${APT} install -qq ansible curl git openssh-server python3-pip

messenger info "Setting up additional variables"
GIT="$(which git)"
AP="$(which ansible-playbook)"
AG="$(which ansible-galaxy)"
PIP="$(which pip)"

messenger progress "Installing deb-get for additional 3rd party management"
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
${SUDO} mkdir -p /etc/deb-get.d/01-pending-merge

messenger progress "Moving ansible value key to its home location"
if [ -f "${HOME}/${VAULT}" ]; then
    messenger info "Vault key already in proper home location"
else
    if [ -f "${VAULT}" ]; then
        cp ./${VAULT} "${HOME}/${VAULT}"
        chmod 644 "${HOME}/${VAULT}"
    else
        messenger error "Ansible vault key not found and unable to be moved."
        messenger error "Several installation items need the vault key."
        messenger fatal "Exiting installation."
    fi
fi

messenger progress "Creating temporary installation directory and downloading ansible git repo"
mkdir -p ${WORK_DIR}
cd ${WORK_DIR}
${GIT} clone ${URL}
cd ${REPO}
${SUDO} cp ./files/deb-get_submitted /etc/deb-get.d/01-pending-merge/10-submitted

messenger progress "Installing ansible dependencies"
${AG} install -r requirements.yaml --ignore-errors --force
${PIP} install github3.py

messenger progress "Running ansible playbook"
${AP} --vault-password-file "${HOME}/${VAULT}" ./${PLAYBOOK} -c local -K

exit 0




