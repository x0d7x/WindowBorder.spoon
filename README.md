# ✨ outlineX-hs: Highlight Your Active macOS Window with a Custom Border ✨

**Boost your macOS productivity and visual focus with outlineX-hs!** This powerful Hammerspoon module adds a highly customizable, colored border around your currently focused application window, making it effortless to track your active workspace.

https://github.com/user-attachments/assets/55713c7f-b0df-4d57-a5f1-cedaf2de51af

## 🚀 Features & Benefits

- **Instant Visual Focus:** Clearly identify your active window at a glance, reducing distractions and improving workflow.
- **Fully Customizable:**
  - **`borderColor`**: Choose any hex color (e.g., `#FF8800` for vibrant orange, `#00FF00` for a subtle green).
  - **`borderWidth`**: Adjust the thickness of the border (e.g., `6` pixels for a prominent highlight).
  - **`cornerRadius`**: Smooth out the border's corners for a modern aesthetic (e.g., `10` for rounded edges).
- **Lightweight & Efficient:** Built on Hammerspoon, ensuring minimal system resource usage.
- **Seamless Integration:** Easily integrate into your existing Hammerspoon configuration.
- **Open Source & Free:** Customize and use it freely to enhance your macOS desktop experience.

## 💡 Why Use outlineX-hs?

In a multi-window environment, it's easy to lose track of which application is truly active. outlineX-hs solves this by providing a clear, visual indicator. Whether you're a developer juggling multiple terminals, a designer switching between creative apps, or simply someone who wants better control over their digital workspace, this tool helps you maintain focus and improve your overall **macOS window management**.

## 🛠️ Installation

To use outlineX-hs, you first need to have [Hammerspoon](https://www.hammerspoon.org/) installed. Hammerspoon is a powerful automation tool for macOS that allows you to control your desktop environment with Lua scripting.

1. **Download Hammerspoon:** If you don't have it already, download and install Hammerspoon from their official website: [https://www.hammerspoon.org/](https://www.hammerspoon.org/)

2. **Clone the Repository:** Open your Terminal and navigate to your Hammerspoon Spoons directory. If it doesn't exist, create it.

   ```bash
   cd ~/.hammerspoon/Spoons
   git clone https://github.com/x0d7x/outlineX-hs
   ```

## 🚀 Usage & Configuration

After installation, you need to load and configure outlineX-hs in your Hammerspoon configuration file, typically `~/.hammerspoon/init.lua`.

1. **Edit `~/.hammerspoon/init.lua`:** Open this file in your favorite text editor.

2. **Add Configuration:** Copy and paste the following lines into your `init.lua` file. You can adjust the `borderColor`, `borderWidth`, and `cornerRadius` to match your preferences.

   ```lua
   -- Load the OutlineX Spoon
   local ox = hs.loadSpoon("OutlineX_hs")

   -- Configure the border appearance (optional, defaults are applied if not set)
   ox.borderWidth = 6
   ox.borderColor = "#FF8800"
   ox.borderAlpha = 1
   ox.cornerRadius = 14

   -- Start the OutlineX functionality
   ox:start()
   ```

   **Note:** If you prefer to configure `OutlineX_hs` directly within your `init.lua` without using the `spoon` global, you can use the `local ox = hs.loadSpoon("OutlineX_hs")` approach as shown above.

   - **`spoon.OutlineX.borderColor`**: Sets the color of the border. Use a hex color code.
   - **`spoon.OutlineX.borderWidth`**: Sets the thickness of the border in pixels.
   - **`spoon.OutlineX.cornerRadius`**: Sets the radius for rounded corners in pixels.

3. **Reload Hammerspoon:** After saving `init.lua`, reload your Hammerspoon configuration (usually by clicking the Hammerspoon icon in your menubar and selecting "Reload Config" or by pressing `Cmd + Opt + Ctrl + R`).

### 🛑 Stopping the Border

To temporarily disable the window border without removing the configuration, you can call:

```lua
ox:stop()
```

### ▶️ Restarting the Border

If you've stopped the border and wish to restart it, simply call:

```lua
ox:start()
```

## 🤝 Contributing

Contributions are welcome! If you have ideas for new features, improvements, or bug fixes, please feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/x0d7x/outlineX-hs).

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
