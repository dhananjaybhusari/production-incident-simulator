#!/usr/bin/env bash
# ==============================================================================
# simulator.sh - Master Incident Simulator CLI
# ==============================================================================

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "[!] Please run this script with sudo: sudo ./simulator.sh"
    exit 1
fi

# Simple ANSI colors for clean display
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'

show_menu() {
    clear
    echo -e "${CYAN}==============================================================${RESET}"
    echo -e "${CYAN}       [SRE] Production Incident Simulator & War Room         ${RESET}"
    echo -e "${CYAN}==============================================================${RESET}"
    echo " Available Scenarios:"
    echo "   [1] Scenario 01: Silent Port Drop       (Connection Timeout)"
    echo "   [2] Scenario 02: Service Daemon Down    (Connection Refused)"
    echo "   [3] Scenario 03: Disk Space Exhaustion  (100% Full / No Space)"
    echo ""
    echo " Actions:"
    echo -e "   ${RED}[B] Break / Inject Fault${RESET}"
    echo -e "   ${GREEN}[V] Verify Resolution (Test your fix)${RESET}"
    echo -e "   ${YELLOW}[F] Fix / Apply Auto-Remediation${RESET}"
    echo "   [Q] Quit"
    echo -e "${CYAN}==============================================================${RESET}"
}

get_scenario_folder() {
    case "$1" in
        1) echo "scenarios/01-net-port-drop" ;;
        2) echo "scenarios/02-sys-service-down" ;;
        3) echo "scenarios/03-disk-space-full" ;;
        *) echo "" ;;
    esac
}

run_action() {
    local scenario_num="$1"
    local action="$2" # break, verify, fix

    folder=$(get_scenario_folder "$scenario_num")

    if [ -z "$folder" ]; then
        echo -e "${RED}[!] Invalid scenario number: $scenario_num${RESET}"
        return
    fi

    echo ""
    case "$action" in
        break)  bash "$folder/break.sh" ;;
        verify) bash "$folder/verify.sh" ;;
        fix)    bash "$folder/fix.sh" ;;
    esac
    echo ""
}

# Support command line shortcuts: e.g. "./simulator.sh break 1"
if [ "$#" -ge 2 ]; then
    run_action "$2" "$1"
    exit 0
fi

# Interactive Menu Loop
while true; do
    show_menu
    read -p "Select an action [B/V/F/Q]: " action_choice

    case "$action_choice" in
        [bB]*)
            read -p "Which scenario number to BREAK? [1-3]: " num
            run_action "$num" "break"
            read -p "Press Enter to continue..."
            ;;
        [vV]*)
            read -p "Which scenario number to VERIFY? [1-3]: " num
            run_action "$num" "verify"
            read -p "Press Enter to continue..."
            ;;
        [fF]*)
            read -p "Which scenario number to FIX? [1-3]: " num
            run_action "$num" "fix"
            read -p "Press Enter to continue..."
            ;;
        [qQ]*)
            echo "Exiting simulator. Happy troubleshooting!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose B, V, F, or Q."
            sleep 1
            ;;
    esac
done
