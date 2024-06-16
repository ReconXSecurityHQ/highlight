## OUTPUT HIGHLIGHTER FOR TERMINAL

`highlight` is a script designed to highlight specific patterns in log files or text streams using ANSI escape codes for colorization. It can detect and highlight patterns such as URLs, domains, IPv4 addresses, IPv6 addresses, subnets, ports, categories, HTML tags, and more.

![image](https://github.com/ReconXSecurityHQ/highlight/assets/91930988/9186afcb-fe00-4372-938c-24426d6b3752)

## Features

- Highlights URLs (http, https, ftp, ftps, sftp, ssh, telnet, file, git), both with and without www
- Recognizes and highlights domains with and without ports.
- Highlights IPv4 addresses and subnet masks.
- Detects and highlights IPv6 addresses.
- Highlights ports (e.g., `80/tcp`, `443/udp`).
- Recognizes and highlights categories or labels followed by a colon (`:`).
- Identifies and highlights HTML tags and their attributes.
- Highlights text within parentheses (`(...)`).
- Colorizes text within double quotes (`"..."`).

## Installation

1. **Clone the repository:**

```bash
git clone https://github.com/ReconXSecurityHQ/highlight.git
 cd highlight
```

2. **Run setup and reload the source script:**

```bash
chmod +x setup
./setup
source ~/.bashrc
```
**in case you encounter this:**

```bash
$ ./setup
-bash: ./setup: cannot execute: required file not found
```

**just try to run this and reload the source**
```bash
dos2unix setup; ./setup
```

## Usage
Once installed, use the `highlight` command followed by the file name or pipe input from another command.

## examples

**Highlight patterns in a log/text file:**
```bash
highlight < access.log
```

**Highlight patterns in nmap scan results:**
```bash
sudo nmap -sV -sC -Pn hackerone.com | highlight
```

**Highlight IP addresses in ifconfig output:**
```bash
ifconfig | highlight
```
**Highlight URLs in curl output:**
```bash
curl -s -i https://www.hackerone.com | highlight
```

## Customization
You can customize or extend the script by modifying the `highlight` function defined within `highlight.sh`. This function uses `awk` to match and replace patterns with ANSI escape sequences for colorization. Each pattern is matched using regular expressions tailored to its specific format (URLs, IP addresses, domains, etc.).

**To add or modify patterns:**

- Edit the highlight function inside highlight.sh.
- Adjust or add gsub commands to match new patterns or change existing highlighting behavior.

##  Notes
- Ensure your terminal emulator supports ANSI escape codes for proper color rendering.
- Modify the script according to your specific needs or additional highlighting patterns.
- Feedback and contributions are welcome. Feel free to fork the repository and submit pull requests for improvements.


for detailed explanation and usage check out full details here: [Enhance Your Terminal Experience with Highlight Tools: A Comprehensive Guide](https://medium.com/p/e8f1c4555c29) 