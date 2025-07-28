# WindowBorder.spoon

Adds a configurable colored border around the focused window on macOS (Hammerspoon).

## Installation

install hammerspoon app from <https://www.hammerspoon.org/>

```bash
cd ~/.hammerspoon/Spoons
git clone https://github.com/x0d7x/WindowBorder.spoon
```

## Usage

edit `~/.hammerspoon/init.lua`

Copy and paste the following lines:

```lua
hs.loadSpoon("WindowBorder")

spoon.WindowBorder.borderColor = "#FF8800"

spoon.WindowBorder.borderWidth = 6

spoon.WindowBorder.cornerRadius = 10

spoon.WindowBorder:start()
```

> [!NOTE]
> to disable the border, call spoon.WindowBorder:stop()
