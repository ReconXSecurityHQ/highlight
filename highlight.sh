#!/bin/bash
RESET="\033[0m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
RED="\033[31m"
BLUE="\033[34m"

# Function to display usage information
usage() {
    echo "Usage: highlight < file"
    echo "       <command> | highlight"
    echo "Description: A script to highlight specific patterns in log files or text streams."
    echo "Patterns highlighted include:"
    echo "  - IPv4 addresses"
    echo "  - IPv6 addresses"
    echo "  - Subnet masks"
    echo "  - URLs"
    echo "  - Domains with ports"
    echo "  - Common network ports"
    echo "  - Important script details"
    echo "  - Text inside parentheses"
    echo "  - HTML tags and attributes"
    exit 1
}

# Check if input is provided
if [ -t 0 ] && [ $# -eq 0 ]; then
    usage
fi

highlight() {
    awk -v RESET="$RESET" -v CYAN="$CYAN" -v GREEN="$GREEN" -v YELLOW="$YELLOW" -v MAGENTA="$MAGENTA" -v RED="$RED" -v BLUE="$BLUE" '
        {
            # Highlight IPv4 addresses
            gsub(/([0-9]{1,3}\.){3}[0-9]{1,3}/, GREEN "&" RESET)

            # Highlight IPv6 addresses
            gsub(/([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}/, MAGENTA "&" RESET)

            # Highlight netmask
            gsub(/netmask [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/, YELLOW "&" RESET)

            # Highlight URLs
            gsub(/(https?|ftp|ftps|sftp|ssh|telnet|file|git):\/\/[^ \t\n\r\f\v<>"]+|(www\.)?([a-zA-Z0-9_-]+\.[a-zA-Z]{2,6})(\/\S*)?/, BLUE "&" RESET)

            # Highlight domains with ports (stop at space or punctuation)
            gsub(/^(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$/, MAGENTA "&" RESET)

            # Highlight ports (assuming common formats)
            gsub(/[0-9]+\/tcp|udp/, GREEN "&" RESET)

            # Highlight important script details (e.g., title, category)
            gsub(/[a-zA-Z0-9-]+:\s/, CYAN "&" RESET)

            # Highlight text inside parentheses (text)
            gsub(/\([^)]+\)/, YELLOW "&" RESET)

            # HTML tags and attribute highlighting
            {
                gsub(/<[^<>]+>/, RED "&" RESET)

                # Highlight attributes
                gsub(/ [a-zA-Z-]+="[^"]*?+"/, GREEN "&" RESET)

                # Highlight text inside double quotes
                gsub(/"[^"]*?+/, YELLOW "&" RESET)
            }

            print
        }
    '
}

