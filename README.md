# Kobo Optimization Guide

This repository contains a pre-configured setup for Kobo devices, aimed at power users who want to unlock more potential of their e-reader. This setup includes **NickelMenu** (with Dark Mode and Cloud support), **Calibre-Web Automated (CWA)** integration, high-quality **NV-optimized fonts**, improved **Wiktionary dictionaries**, and **Tailscale VPN** support.

---

## 📦 What's in this Repo?

- **`KoboRoot.tgz`**: The NickelMenu installer — not included in this repo, download from [pgaskin.net/NickelMenu](https://pgaskin.net/NickelMenu/).
- **`Kobo eReader.conf`**: Pre-configured system file enabling Dropbox, Google Drive, and CWA API endpoints.
- **`config`**: The NickelMenu configuration file for Dark Mode, Cloud, Reboot, and Tailscale shortcuts.
- **`fonts/`**: A collection of NV-optimized fonts (Bookerly, Atkinson Hyperlegible, etc.).
- **`dict/`**: High-quality Wiktionary-based dictionaries — not included in this repo, download from the [Reader-Dict Project](https://github.com/reader-dict/monolingual).

---

## 🛠 Features Included

### 🌑 Dark Mode
Toggle Dark Mode instantly via the NickelMenu button.

### ☁️ Cloud & Wireless Sync
Direct access to Dropbox and Google Drive, plus automated syncing with **Calibre-Web-Automated**. Books appear automatically when hitting "Sync".

### 📖 Enhanced Typography
This setup uses the **NV Font Collection**, which is specifically patched for Kobo firmware to allow advanced weight (thickness) adjustments and better kerning.

### 🔒 Tailscale VPN
Connect your Kobo to your Tailscale network for secure remote access. Toggle the VPN on/off directly from the NickelMenu.

---

## 🚀 Installation Instructions

### 1. Initial Setup
* Ensure your Kobo is connected to your PC.
* Make sure your computer is set to **"Show hidden files and folders"** (to see the `.kobo` directory).

### 2. Install NickelMenu
1. Download `KoboRoot.tgz` from [pgaskin.net/NickelMenu](https://pgaskin.net/NickelMenu/).
2. Copy it into the `.kobo/` folder on your e-reader.
3. Eject the Kobo and unplug it. The device will restart and install NickelMenu.

### 3. System Configuration (Cloud & CWA)
1. Reconnect your Kobo to the PC.
2. Navigate to `.kobo/Kobo/`.
3. Open `Kobo eReader.conf` (or replace it with the one from this repo).
   * **Note:** If replacing, make sure to edit the `api_endpoint` under `[OneStoreServices]` with your own Calibre-Web URL:
     ```ini
     [OneStoreServices]
     api_endpoint=http://your-server-ip:8083/kobo/your-unique-key
     ```

### 4. Setup NickelMenu Shortcuts
1. Navigate to `.adds/nm/` (create the `nm` folder if it doesn't exist).
2. Copy the `config` file from this repo into that folder.
3. This adds shortcuts for **Dark Mode**, **Dropbox**, **Google Drive**, **Reboot**, and **Tailscale** (up and down).
   * *(Optional)* If you want the Tailscale items to also auto-switch the CWA API endpoint, replace the placeholder URLs in the two `Tailscale` lines with your actual local and Tailscale IPs — see **Step 7b** below.

### 5. Install Custom Fonts
1. Go to the root of your Kobo storage.
2. Create a folder named `fonts` (lowercase).
3. Copy the subfolders from the `fonts/` directory in this repo into that folder.
   * *Recommended:* Use **KF_Readerly** (Bookerly) or **KF_Legible_Next** (Atkinson) for the best experience.

### 6. Install Dictionaries
1. Download the desired dictionary files from the [Reader-Dict Project](https://github.com/reader-dict/monolingual) (e.g. `dicthtml-en-en.zip`, `dicthtml-da-da.zip`).
2. Navigate to `.kobo/custom-dict/` on your Kobo (create the folder if it doesn't exist).
3. Copy the `.zip` files into that folder. Do **not** unzip them.
   * *Note:* Safari on macOS may auto-unzip files — check your download settings if this happens.

### 7. Install Tailscale
Tailscale lets you access your Kobo remotely over a secure VPN mesh network.

> **Supported devices:** Kobo Clara BW, Kobo Libra 2, Kobo Libra Colour/Color

> **Important:** The install script writes to system paths on the Kobo's internal Linux filesystem and must be run **on the device itself via SSH** — not from your PC.

#### 7.1 Copy the kobo-tailscale repo to onboard storage
1. Download or clone the [kobo-tailscale](https://github.com/madslundt/kobo-tailscale) repository.
2. With your Kobo connected via USB, copy the folder matching your device (e.g. `clara-bw`) onto the Kobo's onboard storage root.
   - On the device this maps to `/mnt/onboard/clara-bw`.

#### 7.2 Enable SSH on the Kobo
If SSH is not already enabled, tap the firmware version **5 times** in **Settings > Device information** to enable developer mode, which opens the SSH server.

#### 7.3 Connect to WiFi and find the IP address
1. On the device: **Settings > Network > Wi-Fi** — connect to your network. The install script downloads the Tailscale binary, so WiFi must be active during installation.
2. Note the IP address shown under **Settings > Device information**.

#### 7.4 SSH into the device
From your terminal (default root password is blank — press Enter):
```sh
ssh root@<kobo-ip>
```

#### 7.5 Run the install script
```sh
cd /mnt/onboard/clara-bw
sh install-tailscale.sh
```
The script will:
- Copy iptables binaries to `/sbin` and `/lib`
- Download the Tailscale binary from `pkgs.tailscale.com`
- Install Tailscale to `/mnt/onboard/tailscale` and symlink into `/usr/bin`
- Copy lifecycle scripts to `/usr/local/tailscale`
- Install udev rules to `/etc/udev/rules.d/98-tailscale.rules`
- Start the `tailscaled` daemon

#### 7.6 Authenticate Tailscale
Still in the SSH session:
```sh
tailscale up
```
This prints a URL — open it on another device/browser to log in and authorize the Kobo.

#### 7.7 Verify the installation
```sh
tailscale status          # should show the device connected to your tailnet
ls /mnt/onboard/tailscale # should contain tailscale, tailscaled, and state files
ls /usr/local/tailscale   # should contain the boot/wlan scripts
```

#### 7.8 *(Optional)* Disable Tailscale DNS
If DNS stops working after connecting:
```sh
tailscale set --accept-dns=false
```

#### 7.9 NickelMenu shortcuts
The NickelMenu shortcuts added by this repo's `config` file let you toggle Tailscale on/off directly from the Kobo menu:
- **Tailscale** → connects (`tailscale.sh up`)
- **Tailscale Down** → disconnects (`tailscale.sh down`)

#### 7.10 *(Optional)* Use Tailscale IP for Calibre-Web-Automated
To access CWA when away from home, update `api_endpoint` in `.kobo/Kobo/Kobo eReader.conf` to your server's Tailscale IP:
```ini
[OneStoreServices]
api_endpoint=http://<tailscale-ip>:8083/kobo/your-unique-key
```

### 7b. *(Optional)* Auto-switch API endpoint on Tailscale toggle

Instead of manually editing `Kobo eReader.conf` each time you switch networks, you can have the Tailscale menu items update `api_endpoint` automatically.

1. Open the `config` file from this repo and fill in your actual URLs in the two Tailscale lines:
   ```
   # Replace http://your-tailscale-ip:8083/kobo/your-key with your Tailscale server IP
   # Replace http://your-local-ip:8083/kobo/your-key with your local network server IP
   ```
2. On your Kobo, create the folder `.adds/kobo-cwa/`.
3. Copy `scripts/switch-api.sh` from this repo into that folder and make it executable:
   ```sh
   chmod +x /mnt/onboard/.adds/kobo-cwa/switch-api.sh
   ```
4. Copy the updated `config` file to `.adds/nm/config`.

**How it works:**
- **Tailscale** / **Tailscale Down** — connects or disconnects, then shows a dialog if the API endpoint was changed. Dismiss the dialog, then tap **Reboot** in the menu to apply immediately, or continue reading and reboot later.
- If the endpoint is already set correctly (e.g. toggling back before rebooting), no dialog appears and the toggle is silent.
- The **Reboot** menu item syncs the active endpoint state before rebooting so the tracking stays accurate.

---

## 📜 Credits
- **NickelMenu:** [pgaskin.net](https://pgaskin.net/NickelMenu/)
- **NV Fonts:** [Nico Verbruggen](https://github.com/nicoverbruggen/ebook-fonts)
- **Dictionaries:** [Reader-Dict Project](https://github.com/reader-dict/monolingual)
- **Calibre-Web-Automated:** [crocodilestick/Calibre-Web-Automated](https://github.com/crocodilestick/Calibre-Web-Automated)
- **Tailscale on Kobo:** [videah/kobo-tailscale](https://github.com/videah/kobo-tailscale)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---
*Disclaimer: Modifying your Kobo is done at your own risk. Always keep a backup of your original `Kobo eReader.conf` file.*
