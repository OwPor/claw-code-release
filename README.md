# 🦞 Claw Code (Windows Portable Wrapper)

A pre-compiled Windows setup for `claw-code` (the Rust reimplementation of Anthropic's Claude Code CLI). 

This repository includes a custom wrapper designed to make `claw-code` work seamlessly with **OpenRouter** and other OpenAI-compatible endpoints on Windows out of the box. It uses a custom batch script to load your API keys dynamically, keeping your global system environment perfectly clean.

## 🚀 Quick Start

1. **Clone or Download** this repository to your local machine:
   ```cmd
   git clone [https://github.com/OwPor/claw-code-release.git](https://github.com/OwPor/claw-code-release.git)
   cd claw-code
   ```
2. **Edit** the `settings.json` file in any text editor.
3. **Paste** your OpenRouter Model where it says `"PROVIDER/MODEL"`.
4. **Paste** your OpenRouter API key where it says `"sk-or-v1-YOUR_OPENROUTER_KEY_HERE"`.
5. Open your terminal in this folder and run:
   ```cmd
   claw
   ```

## 💬 Interacting with the Agent
To talk to the agent, you must launch it first. Run the `claw` command to start the interactive session:
```cmd
claw
```

## 🌍 Run Claw from Anywhere (Optional)
If you want to be able to open a terminal in any project folder and type `claw` without having to navigate back to this installation folder first, you need to add this folder to your Windows system PATH.

1. **Copy the folder path:** Copy the full path to the directory where you cloned or extracted this repository (e.g., `C:\Users\YourName\Documents\claw-code-release`).
2. Press the **Windows Key**, type `env`, and press **Enter** (this opens "Edit the system environment variables").
3. Click the **Environment Variables...** button at the bottom right.
4. In the top box (User variables), select the **Path** variable and click **Edit...**
5. Click **New** and paste the folder path you copied in Step 1.
6. Click **OK** on all three windows to save.
7. **Restart your terminal:** You must close your current terminal completely and open a new one. You can now use the `claw` command in any directory on your computer!

## 🛠️ Important Prerequisites for Windows
Because Claw is an autonomous agent, it expects to be able to read files, run terminal commands, and navigate your system. **To prevent "executable not found" errors, you should have the following installed:**

**1. Git Bash (Required for the `bash` tool)**
The agent strongly prefers running Linux commands like `ls` and `cat`.
```powershell
winget install --id Git.Git -e --source winget
```
*Note: During installation, ensure you select "Git from the command line and also from 3rd-party software" so it gets added to your system PATH.*

**2. PowerShell 7 (Recommended for Windows commands)**
The agent works best with modern PowerShell (`pwsh`) rather than legacy Windows PowerShell.
```powershell
winget install --id Microsoft.Powershell --source winget
```

*(Always restart your terminal completely after installing these tools!)*

## 🧠 Changing Models
You can change your default model at any time by editing the `model` string in `settings.json`. 

Because this setup routes through OpenRouter's OpenAI-compatible endpoint.

**Examples:**
* `"model": "nvidia/nemotron-3-super-120b-a12b:free"`
* `"model": "google/gemini-2.5-pro"`
* `"model": "qwen/qwen-2.5-coder-32b-instruct"`

## ⚙️ How it Works
To avoid polluting your global Windows Registry with permanent API keys, this setup uses a custom launcher:
* When you type `claw`, Windows executes the `claw.bat` script.
* The script instantly reads your `settings.json` file and loads your keys into a temporary, isolated session.
* It then hands off execution to `claw_.exe` (the actual compiled Rust binary).
* The moment you exit the program, your keys vanish from memory.
