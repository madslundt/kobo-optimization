# Kobo Optimization Guide

This repository contains a pre-configured setup for Kobo devices, aimed at power users who want to unlock more potential of their e-reader. This setup includes **NickelMenu** (with Dark Mode and Cloud support), **Calibre-Web Automated (CWA)** integration, high-quality **NV-optimized fonts**, improved **Wiktionary dictionaries**, and **Tailscale VPN** support.

---

## 📦 What's in this Repo?

- **`KoboRoot.tgz`**: The NickelMenu installer — not included in this repo, download from [pgaskin.net/NickelMenu](https://pgaskin.net/NickelMenu/).
- **`Kobo eReader.conf`**: Pre-configured system file enabling Dropbox, Google Drive, and CWA API endpoints.
- **`config`**: The NickelMenu configuration file for Dark Mode, Cloud, Reboot, and Tailscale shortcuts.
- **`fonts/`**: A collection of NV-optimized fonts (Bookerly, Atkinson Hyperlegible, etc.).
- **`scripts/`**: Helper scripts for Tailscale installation and management.
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

#### 7.1 Copy kobo-tailscale to the Kobo
1. Download or clone the [kobo-tailscale](https://github.com/videah/kobo-tailscale) repository.
2. Open `clara-bw/install-tailscale.sh` and check `TAILSCALE_VERSION` at the top — update it to the [latest stable release](https://pkgs.tailscale.com/stable/#static) if needed.
3. Copy `scripts/run-tailscale-install.sh` and `scripts/run-tailscale-auth.sh` from **this repo** into `.adds/kobo-cwa/` on your Kobo.
4. Copy the `clara-bw` folder onto the Kobo's onboard storage root (`/mnt/onboard/clara-bw`).

#### 7.2 Enable the install menu items
In `.adds/nm/config`, uncomment the three **Step 1** lines in the Tailscale section, then eject and unplug.

#### 7.3 Install
1. Make sure WiFi is connected on the Kobo.
2. Tap **Install Tailscale** — runs in the background.
3. Tap **Tailscale Log** to confirm it succeeded.

#### 7.4 Authenticate
1. Tap **Tailscale Auth** — runs in the background.
2. Wait a few seconds, then tap **Tailscale Log** to get the login URL.
3. Open the URL on another device to authorize the Kobo.
4. Tap **Tailscale Log** again to verify the connection succeeded.

#### 7.5 Enable the Tailscale shortcuts
Reconnect via USB and open `.adds/nm/config`:
- Remove the three **Step 1** lines from step 7.2.
- Uncomment the two **Step 2** lines to enable the **Tailscale** / **Tailscale Down** shortcuts.

#### 7.6 *(Optional)* Disable Tailscale DNS
If DNS stops working after connecting, temporarily add this to `.adds/nm/config`, tap it once, then remove it:
```
menu_item:main:Tailscale Fix DNS:cmd_output:9999:tailscale set --accept-dns=false
```

#### 7.7 Uninstall Tailscale
In `.adds/nm/config`, uncomment the **Uninstall Tailscale** line, copy to the Kobo, tap it, then re-comment it.

#### 7.8 *(Optional)* Use Tailscale IP for Calibre-Web-Automated
Update `api_endpoint` in `.kobo/Kobo/Kobo eReader.conf` to your server's Tailscale IP:
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
