# Kobo Optimization Guide

This repository contains a pre-configured setup for Kobo devices, aimed at power users who want to unlock more potential of their e-reader. This setup includes **NickelMenu** (with Dark Mode and Cloud support), **Calibre-Web Automated (CWA)** integration, high-quality **NV-optimized fonts**, and improved **Wiktionary dictionaries**.

---

## 📦 What's in this Repo?

- **`KoboRoot.tgz`**: The NickelMenu installer — not included in this repo, download from [pgaskin.net/NickelMenu](https://pgaskin.net/NickelMenu/).
- **`Kobo eReader.conf`**: Pre-configured system file enabling Dropbox, Google Drive, and CWA API endpoints.
- **`config`**: The NickelMenu configuration file for Dark Mode, WiFi, and Cloud shortcuts.
- **`fonts/`**: A collection of NV-optimized fonts (Bookerly, Atkinson Hyperlegible, etc.).
- **`dict/`**: High-quality Wiktionary-based dictionaries — not included in this repo, download from the [Reader-Dict Project](https://github.com/reader-dict/monolingual).

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
3. This adds shortcuts for **Dark Mode**, **Dropbox**, **Google Drive**, and **Reboot**.

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

---

## 🛠 Features Included

### 🌑 Dark Mode
Toggle Dark Mode instantly via the NickelMenu button.

### ☁️ Cloud & Wireless Sync
Direct access to Dropbox and Google Drive, plus automated syncing with **Calibre-Web**. Books appear automatically when hitting "Sync".

### 📖 Enhanced Typography
This setup uses the **NV Font Collection**, which is specifically patched for Kobo firmware to allow advanced weight (thickness) adjustments and better kerning.

---

## 📜 Credits
- **NickelMenu:** [pgaskin.net](https://pgaskin.net/NickelMenu/)
- **NV Fonts:** [Nico Verbruggen](https://github.com/nicoverbruggen/ebook-fonts)
- **Dictionaries:** [Reader-Dict Project](https://github.com/reader-dict/monolingual)
- **Calibre-Web:** [Janusek/calibre-web](https://github.com/janusek/calibre-web)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---
*Disclaimer: Modifying your Kobo is done at your own risk. Always keep a backup of your original `Kobo eReader.conf` file.*