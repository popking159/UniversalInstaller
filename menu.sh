#!/bin/sh
# =========================================================================
# One-liner execution command (Example):
# wget -qO - https://raw.githubusercontent.com/popking159/UniversalInstaller/main/menu.sh | /bin/sh
# =========================================================================

# Terminal Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

show_menu() {
    clear
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${GREEN}       POPKING159 UNIVERSAL PLUGIN INSTALLER        ${NC}"
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${CYAN}Please select a plugin to install:${NC}"
    echo ""
    echo -e "  ${YELLOW}1)${NC} AdvancedBootLogoSwapper"
    echo -e "  ${YELLOW}2)${NC} Button Patcher"
    echo -e "  ${YELLOW}3)${NC} ArabicSavior"
    echo -e "  ${YELLOW}4)${NC} NovalerDownloader"
    echo -e "  ${YELLOW}5)${NC} AudioSelectionPatcher"
    echo -e "  ${YELLOW}6)${NC} MyWebUIController"
    echo -e "  ${YELLOW}7)${NC} MyHits"
    echo -e "  ${YELLOW}8)${NC} EmuInstaller"
    echo -e "  ${YELLOW}9)${NC} QuranKareem"
    echo -e " ${YELLOW}10)${NC} CacheFlush"
    echo -e " ${YELLOW}11)${NC} CustomChannelSelection"
    echo ""
    echo -e "  ${RED}R)${NC} Restart Enigma2 GUI (Apply Changes)"
    echo -e "  ${RED}0)${NC} Exit"
    echo -e "${GREEN}====================================================${NC}"
}

run_installer() {
    URL="$1"
    echo -e "\n${CYAN}[INFO] Starting installation...${NC}\n"
    wget -qO - "$URL" | /bin/sh
    echo -e "\n${CYAN}[INFO] Process finished.${NC}"
    read -p "Press [Enter] to return to the menu..." dummy
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

while true; do
    show_menu
    read -p "Enter your choice [0-11, R]: " choice

    case "$choice" in
        1) run_installer "https://raw.githubusercontent.com/popking159/abls/refs/heads/main/myinstaller.sh" ;;
        2) run_installer "https://raw.githubusercontent.com/popking159/buttonpatcher/refs/heads/main/myinstaller.sh" ;;
        3) run_installer "https://raw.githubusercontent.com/popking159/ArabicSavior/refs/heads/main/myinstaller.sh" ;;
        4) run_installer "https://raw.githubusercontent.com/popking159/novalerdownloader/refs/heads/main/myinstaller.sh" ;;
        5) run_installer "https://raw.githubusercontent.com/popking159/audioselectionpatcher/refs/heads/main/myinstaller.sh" ;;
        6) run_installer "https://raw.githubusercontent.com/popking159/mywebuicontroller/refs/heads/main/myinstaller.sh" ;;
        7) run_installer "https://raw.githubusercontent.com/popking159/myhits/refs/heads/main/myinstaller.sh" ;;
        8) run_installer "https://raw.githubusercontent.com/popking159/EmuInstaller/refs/heads/main/myinstaller.sh" ;;
        9) run_installer "https://raw.githubusercontent.com/popking159/QuranKareem/refs/heads/main/myinstaller.sh" ;;
        10) run_installer "https://raw.githubusercontent.com/popking159/cacheflush/refs/heads/main/myinstaller.sh" ;;
        11) run_installer "https://raw.githubusercontent.com/popking159/customchannelselection/refs/heads/main/myinstaller.sh" ;;
        r|R) restart_gui ;;
        0) echo -e "\n${GREEN}Exiting... Have a great day!${NC}\n"; exit 0 ;;
        *) 
            echo -e "\n${RED}[ERROR] Invalid option. Please try again.${NC}"
            sleep 1
            ;;
    esac
done
