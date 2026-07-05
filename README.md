# Keyboard-Mouse-Emulator-
A driver-free AutoHotkey v2 script that turns arrow keys from keyboard into a mouse and game camera that runs on most games even if it has anti-cheat functions.

# KME_Arrow – Universal Keyboard-to-Mouse Emulator

[![AHK v2](https://img.shields.io/badge/AutoHotkey-v2-blue)](https://www.autohotkey.com/v2/)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-lightgrey)](https://www.microsoft.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

**Arrow Mouse Pro** is a lightweight, driver-free, single-file AutoHotkey v2 script designed to transform your keyboard’s **Arrow Keys, Page Up, and Page Down** into a fully-fledged mouse replacement. 

It works natively on Windows 10 and Windows 11 without requiring external drivers, hidden DLLs, or administrative installations (aside from the initial file permission setup). 

---

> **🏆 The Gold Standard of Keyboard-to-Mouse Scripts**  
> While there are dozens of "Arrow Key Mouse" scripts scattered across the internet, almost all of them are broken, outdated, or cannot handle modern anti-cheat engines and fullscreen games. **This script is different.**  
> It was built specifically to solve the issues that every other script ignored: the *fullscreen lock*, the *key deadlocks*, the *Pop-up warnings*, and the *cursor drift*.  
> If you need a keyboard mouse emulator that *actually works* on Windows 10/11 today—without drivers, without DLLs, and without headaches—you just found it.

---

> **🔥 Why this script beats the rest**  
> - ✅ **Fullscreen Support:** Works natively in games like Genshin Impact and Minecraft, *without* requiring borderless windowed mode. Most scripts fail here.  
> - ✅ **Zero Drift:** The timer-based movement system ensures your cursor *never* randomly drifts left or right when you release a key.  
> - ✅ **No Pop-Ups:** We permanently disabled the annoying AHK "Too many hotkeys" warning using `A_HotkeyInterval := 0`.  
> - ✅ **True Drag Support:** Hold `PgUp` + Arrows. It drags. Release `PgUp` while moving. It stops. Instantly.  
> - ✅ **Three Speeds:** Normal, Precision (Ctrl), and Turbo (Alt)—something you won't find in any other free script.

---

## 🎯 Why This Script Exists

Built for gamers, digital artists, and users with accessibility needs, this script solves a universal problem: **How to accurately control a mouse cursor and 3D game camera using only a keyboard.**

It was rigorously tested against aggressive anti-cheat engines (specifically **Genshin Impact** and **Minecraft**) and proves that pure AHK signal injection can bypass modern game locks without triggering bans.

---

## ✨ Features

- **Dual-Mode Movement:** 
  - Uses `MouseMove` for desktop cursor navigation and menu selection.
  - Uses raw `DllCall("mouse_event")` injection to seamlessly rotate 3D cameras in games when the cursor is locked.
- **Toggle System:** Double-tap the **` (Backtick)** key to instantly toggle the mouse emulation ON or OFF.
- **Smart Drag & Drop:** Hold **Page Up (PgUp)** while pressing Arrow keys to simulate holding down the left mouse button and dragging (ideal for moving files or selecting text).
- **Dynamic Multi-Speed System:**
  - **Normal Speed:** Standard cursor velocity for day-to-day desktop work.
  - **Precision Mode (Hold Ctrl):** Cuts the cursor speed by exactly 50%, allowing for pixel-perfect photo editing, CAD adjustments, or clicking tiny UI elements.
  - **Turbo Mode (Hold Alt):** Dramatically increases movement speed, perfect for fast camera panning in open-world games like Genshin Impact or Minecraft.
- **Right-Click Support:** **Page Down (PgDn)** instantly triggers a standard right-click.
- **No Key Ghosting:** The script utilizes a background `SetTimer` loop to eliminate AHK’s default key-repeat deadlocks, ensuring flawless execution of diagonal ("Queen") movements without locking up individual keys.

---

## 🎮 Tested Compatibility (Verified to work on Fullscreen)

| Platform / Game | Status | Notes |
| :--- | :--- | :--- |
| **Windows Desktop / Explorer** | ✅ **Perfect** | Mouse movement, drag, and clicks work flawlessly. |
| **Web Browsers (Chrome, Edge)** | ✅ **Perfect** | Used to write this description; no cursor drift. |
| **Genshin Impact** | ✅ **Perfect** | Works natively in **Fullscreen** and Borderless modes; camera rotates smoothly. |
| **Minecraft (Java / Browser)** | ✅ **Perfect** | Pointer lock accepted; camera pans instantly. |
| **Digital Art Software (Photoshop)** | ✅ **Perfect** | Precision (Ctrl) mode enables exact pixel painting. |
| **Steam / Epic Launchers** | ✅ **Perfect** | Navigation and clicking work seamlessly. |

---

## ⚙️ Technical Requirements & Setup

- **Software:** [AutoHotkey v2](https://www.autohotkey.com/v2/) (The script will not work on v1.1).
- **Operating System:** Windows 10 or Windows 11.
- **Hardware:** Any standard USB or laptop keyboard with Arrow Keys, PgUp, and PgDn.

**Crucial Setup Step (Required for Games):**
1. After downloading the `.ahk` file, **right-click it** and select **Properties**.
2. Click the **Advanced** button.
3. Check the box labeled **"Run as administrator"**.
4. Click OK, then Apply. 
*(This elevates the script's privileges, allowing the `DllCall("mouse_event")` signals to bypass game-level input locks).*

---

## ⌨️ Default Control Reference (Quick Cheat Sheet)

| Key Combination | Action |
| :--- | :--- |
| **Double-tap ` (Backtick)** | Toggle Mouse Mode On / Off |
| **Arrow Keys** | Move Desktop Cursor / Pan Game Camera |
| **Hold PgUp + Arrow Keys** | Left Click + Drag (File moving/Text highlighting) |
| **PgDn** | Right Click |
| **Hold Ctrl + Arrow Keys** | Precision Speed (Slow / Pixel-perfect) |
| **Hold Alt + Arrow Keys** | Turbo Speed (Fast camera panning) |

---

## 📂 How to Download & Share

1. Click the green **"Code"** button at the top-right of this repository.
2. Select **"Download ZIP"**.
3. Extract the ZIP folder anywhere on your PC.
4. Run `KME_Arrow.ahk`.
| **You must download AutoHotKey V2 for script to work.**

---

## 🛡️ Is it safe? Is it a bot?
**Yes, it is completely safe.** 
It does not read your system memory, does not interact with Genshin's file structure, and does not inject malicious code. It merely intercepts your keyboard inputs and translates them into Windows Mouse Events in real-time. 

*Note: Because the movement is mathematically straight and consistent, Cloudflare or reCAPTCHA might flag it as a "robot". This is expected; simply toggle the script off (double-tap `` ` ``) to solve a CAPTCHA with your physical mouse, and toggle it back on afterwards.*

---

## 🤝 Contributing & Evolution
If you wish to fork this repository and modify it for your own specific ergonomic layout, feel free to do so. This project is open-source and built to help anyone who has a broken mouse, a laptop trackpad injury, or simply prefers keyboard-based navigation.

Enjoy your new mouse. You don't need to buy one anymore. 🖱️⌨️
