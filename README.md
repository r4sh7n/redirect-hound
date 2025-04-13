# Redirect Hound v1.0

`Redirect Hound` is a simple yet powerful bash script designed to detect open redirect vulnerabilities across domains by analyzing JavaScript-related URLs. The script uses the `gau` (Go-based URL collector) tool to fetch potential redirect parameters and tests them for vulnerabilities. It's ideal for bug hunters and penetration testers looking to identify open redirects in web applications.

### Features:
- **Open Redirect Detection**: Scans a target domain for open redirect vulnerabilities by checking common redirect parameters in URLs.
- **Automated Setup**: Installs necessary dependencies (Go, gau, curl, grep) automatically if not already installed.
- **Easy to Use**: Just enter the target domain, and let the script do the work.
- **Colorful Output**: Provides clear, color-coded terminal output to easily identify found issues.
- **Self-Installer**: Automatically installs missing tools and sets up environment variables.

---

## Requirements

Before running the script, ensure you have the following installed on your system:

- **Go (Golang)**: For installing and running the `gau` tool.
- **gau**: A Go-based URL collector used for gathering potential redirect URLs.
- **curl**: For testing the redirect functionality.
- **grep**: For filtering URLs containing redirect parameters.

If you don't have these tools, the script will install them for you.

---

## Installation

1. **Clone the repository** (or download the script).
   ```bash
   git clone https://github.com/4stersec/redirect-hound.git
   cd redirect-hound
   ```

2. **Make the script executable**:
   ```bash
   chmod +x redirect-hound.sh
   ```

3. **Run the script**:
   ```bash
   ./redirect-hound.sh
   ```

---

## Usage

1. **Run the script**:
   ```bash
   ./redirect-hound.sh
   ```

2. **Enter the target domain** when prompted (e.g., `example.com`):
   ```
   Enter domain (example.com): example.com
   ```

3. **Wait for the script to finish**. It will output a list of found open redirects (if any), saved in `results/[domain]/vulnerable.txt`.

---

## Script Breakdown

1. **Banner**: Displays an ASCII art banner and script information.
2. **Self-Installer**: Checks for and installs any missing dependencies (Go, gau, curl, grep).
3. **Redirect Scanner**: 
   - Fetches URLs with potential redirect parameters using `gau`.
   - Tests each URL by appending `evil.com` to check for open redirects.
   - Logs vulnerable URLs to `results/[domain]/vulnerable.txt`.

---

## Example Output

```bash
[+] Target: example.com
[*] Fetching JS-related URLs with redirect params...
[*] Testing URLs for open redirects...
[!] Open Redirect Found: http://example.com/redirect?url=evil.com
[✔] Scan complete. Results saved to: results/example.com/vulnerable.txt
```

---

## Contributing

Feel free to open an issue or submit a pull request if you find bugs or have feature suggestions.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

### 📢 Acknowledge

- **gau**: https://github.com/lc/gau (Go-based URL collector)
- **curl**: https://curl.se/
```
