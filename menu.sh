#!/bin/sh
# =========================================================================
# Standard Menu Execution:
# wget -qO - https://raw.githubusercontent.com/popking159/UniversalInstaller/main/menu.sh | /bin/sh
#
# Unattended "Install ALL" Execution:
# wget -qO - https://raw.githubusercontent.com/popking159/UniversalInstaller/main/menu.sh | /bin/sh -s all
# =========================================================================

# Terminal Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

AUTO_MODE=0

show_menu() {
    clear
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${GREEN}       POPKING159 UNIVERSAL PLUGIN INSTALLER        ${NC}"
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${CYAN}Please select an option:${NC}"
    echo ""
    echo -e "  ${YELLOW}1)${NC} [SETUP] Install Essential Packages & Dependencies"
    echo -e "----------------------------------------------------"
    echo -e "  ${YELLOW}2)${NC} AdvancedBootLogoSwapper"
    echo -e "  ${YELLOW}3)${NC} Button Patcher"
    echo -e "  ${YELLOW}4)${NC} ArabicSavior"
    echo -e "  ${YELLOW}5)${NC} NovalerDownloader"
    echo -e "  ${YELLOW}6)${NC} AudioSelectionPatcher"
    echo -e "  ${YELLOW}7)${NC} MyWebUIController"
    echo -e "  ${YELLOW}8)${NC} MyHits"
    echo -e "  ${YELLOW}9)${NC} EmuInstaller"
    echo -e " ${YELLOW}10)${NC} QuranKareem"
    echo -e " ${YELLOW}11)${NC} CacheFlush"
    echo -e " ${YELLOW}12)${NC} CustomChannelSelection"
    echo -e " ${YELLOW}13)${NC} IPStreamer"
    echo -e " ${YELLOW}14)${NC} SubsSupportPro"
    echo -e " ${YELLOW}15)${NC} xtraEvent"
    echo -e " ${YELLOW}16)${NC} MyStreamer"
    echo ""
    echo -e "  ${RED}R)${NC} Restart Enigma2 GUI (Apply Changes)"
    echo -e "  ${RED}0)${NC} Exit"
    echo -e "${GREEN}====================================================${NC}"
}

install_dependencies() {
    if [ "$AUTO_MODE" -eq 0 ]; then clear; fi
    echo -e "${CYAN}====================================================${NC}"
    echo -e "${CYAN}         INSTALLING ESSENTIAL DEPENDENCIES          ${NC}"
    echo -e "${CYAN}====================================================${NC}"
    
    # Check for opkg
    if ! command -v opkg >/dev/null 2>&1; then
        echo -e "\n${RED}[ERROR] opkg package manager not found! Cannot install dependencies.${NC}"
        if [ "$AUTO_MODE" -eq 0 ]; then read -p "Press [Enter] to return to the menu..." dummy </dev/tty; fi
        return
    fi

    echo -e "\n${YELLOW}[INFO] Updating package feeds...${NC}"
    opkg update >/dev/null 2>&1

    echo -e "\n${YELLOW}[INFO] Installing System & Python packages...${NC}"
    opkg install xz zstd wget curl softcam-support duktape gstplayer ffmpeg \
        python3-sqlite3 python3-image python3-imaging python3-multiprocessing \
        python3-requests python3-core python3-cryptography python3-backports-lzma \
        python3-pkgutil python3-json unrar python3-futures3 libmad0 streamripper \
        python3-lxml python3-xmlrpc python3-xml python3-urllib3 python3-codecs \
        python3-mutagen python3-difflib python3-pyexecjs python3-treq libdvbcsa \
        gst-ifdsrc python3-pycurl python3-webencodings python3-html5lib \
        python3-soupsieve python3-beautifulsoup4 python3-isodate \
        python3-websocket-client python3-pycountry python3-pycryptodome \
        python3-tinytag python3-zoneinfo python3-dateutil python3-fuzzywuzzy \
        python3-levenshtein python3-js2py gettext

    echo -e "\n${YELLOW}[INFO] Installing standard Enigma2 plugins...${NC}"
    opkg install enigma2-plugin-extensions-dreamexplorer \
        enigma2-plugin-extensions-youtube \
        enigma2-plugin-systemplugins-autoresolution \
        enigma2-plugin-systemplugins-serviceapp \
        enigma2-plugin-extensions-oaweather

    echo -e "\n${GREEN}[OK] Dependency installation finished.${NC}"
    if [ "$AUTO_MODE" -eq 0 ]; then read -p "Press [Enter] to return to the menu..." dummy </dev/tty; fi
}

run_installer() {
    URL="$1"
    echo -e "\n${CYAN}[INFO] Fetching and running: $URL${NC}"
    wget -qO - "$URL" | /bin/sh
    echo -e "${GREEN}[OK] Process finished for this plugin.${NC}\n"
    if [ "$AUTO_MODE" -eq 0 ]; then read -p "Press [Enter] to return to the menu..." dummy </dev/tty; fi
}

restart_gui() {
    echo -e "\n${YELLOW}[INFO] Restarting Enigma2 GUI...${NC}"
    if command -v wget >/dev/null 2>&1; then
        wget -qO - "http://127.0.0.1/web/powerstate?newstate=3" >/dev/null 2>&1
    elif command -v curl >/dev/null 2>&1; then
        curl -s "http://127.0.0.1/web/powerstate?newstate=3" >/dev/null 2>&1
    else
        killall -9 enigma2 >/dev/null 2>&1
    fi
    echo -e "${GREEN}[OK] Restart command sent.${NC}"
    sleep 2
    exit 0
}

# =========================================================================
# MAIN LOGIC
# =========================================================================

# Check if the user passed 'all' or '--all' as an argument
if [ "$1" = "all" ] || [ "$1" = "--all" ]; then
    AUTO_MODE=1
    clear
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${GREEN}      INITIATING UNATTENDED AUTO-INSTALLATION       ${NC}"
    echo -e "${GREEN}====================================================${NC}"
    sleep 2

    # 1. Install dependencies first
    install_dependencies
    
    # 2. Run all plugin installers sequentially
    run_installer "https://raw.githubusercontent.com/popking159/abls/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/buttonpatcher/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/ArabicSavior/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/novalerdownloader/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/audioselectionpatcher/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/mywebuicontroller/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/myhits/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/EmuInstaller/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/QuranKareem/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/cacheflush/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/customchannelselection/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/ipstreamer/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/SubsSupportPro/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/xtraeventplugin/refs/heads/main/myinstaller.sh"
    run_installer "https://raw.githubusercontent.com/popking159/MyStreamer/refs/heads/main/myinstaller.sh"

    # 3. Restart GUI automatically at the end
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${GREEN}      ALL PLUGINS INSTALLED SUCCESSFULLY!           ${NC}"
    echo -e "${GREEN}====================================================${NC}"
    restart_gui

else
    # Standard Interactive Mode
    while true; do
        show_menu
        read -p "Enter your choice [0-16, R]: " choice </dev/tty

        case "$choice" in
            1) install_dependencies ;;
            2) run_installer "https://raw.githubusercontent.com/popking159/abls/refs/heads/main/myinstaller.sh" ;;
            3) run_installer "https://raw.githubusercontent.com/popking159/buttonpatcher/refs/heads/main/myinstaller.sh" ;;
            4) run_installer "https://raw.githubusercontent.com/popking159/ArabicSavior/refs/heads/main/myinstaller.sh" ;;
            5) run_installer "https://raw.githubusercontent.com/popking159/novalerdownloader/refs/heads/main/myinstaller.sh" ;;
            6) run_installer "https://raw.githubusercontent.com/popking159/audioselectionpatcher/refs/heads/main/myinstaller.sh" ;;
            7) run_installer "https://raw.githubusercontent.com/popking159/mywebuicontroller/refs/heads/main/myinstaller.sh" ;;
            8) run_installer "https://raw.githubusercontent.com/popking159/myhits/refs/heads/main/myinstaller.sh" ;;
            9) run_installer "https://raw.githubusercontent.com/popking159/EmuInstaller/refs/heads/main/myinstaller.sh" ;;
            10) run_installer "https://raw.githubusercontent.com/popking159/QuranKareem/refs/heads/main/myinstaller.sh" ;;
            11) run_installer "https://raw.githubusercontent.com/popking159/cacheflush/refs/heads/main/myinstaller.sh" ;;
            12) run_installer "https://raw.githubusercontent.com/popking159/customchannelselection/refs/heads/main/myinstaller.sh" ;;
            13) run_installer "https://raw.githubusercontent.com/popking159/ipstreamer/refs/heads/main/myinstaller.sh" ;;
            14) run_installer "https://raw.githubusercontent.com/popking159/SubsSupportPro/refs/heads/main/myinstaller.sh" ;;
            15) run_installer "https://raw.githubusercontent.com/popking159/xtraeventplugin/refs/heads/main/myinstaller.sh" ;;
            16) run_installer "https://raw.githubusercontent.com/popking159/MyStreamer/refs/heads/main/myinstaller.sh" ;;
            r|R) restart_gui ;;
            0) echo -e "\n${GREEN}Exiting... Have a great day!${NC}\n"; exit 0 ;;
            *) 
                echo -e "\n${RED}[ERROR] Invalid option. Please try again.${NC}"
                sleep 1
                ;;
        esac
    done
fi
