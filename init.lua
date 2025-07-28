--- === WindowBorder ===
---
--- Adds a configurable border around the focused window.
--- Usage:
---   local wb = hs.loadSpoon("WindowBorder")
---   wb.borderWidth  = 6
---   wb.borderColor  = "#FF8800"      -- HEX string or RGBA table
---   wb.cornerRadius = 10
---   wb:start()

local obj = {}
obj.__index = obj

-- ▸ Metadata ------------------------------------------------------
obj.name = "WindowBorder"
obj.version = "1.0"
obj.author = "d7man <di7@hotmail.com>"
obj.homepage = "https://github.com/x0d7x/WindowBorder.spoon"

-- ▸ Default Settings ---------------------------------------------
obj.borderWidth = 4 -- thickness in px
obj.borderColor = { red = 0.20, green = 0.55, blue = 1.00, alpha = 0.90 }
obj.cornerRadius = 6 -- rounded‑rect radius
obj.windowLevel = "overlay" -- or "assistiveTechHigh"

-- ▸ Internals -----------------------------------------------------
obj._border = nil
obj._winFilter = nil
obj._spaceWatcher = nil

-------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------
local function _hideBorder(self)
	if self._border then
		self._border:hide()
	end
end

--- Convert "#RRGGBB" or "#RGB" to rgba table {red=,green=,blue=,alpha=}
local function hex2rgba(hex, alpha)
	hex = hex:gsub("#", "")
	if #hex == 3 then -- expand #RGB → #RRGGBB
		hex = hex:sub(1, 1):rep(2) .. hex:sub(2, 2):rep(2) .. hex:sub(3, 3):rep(2)
	end
	local r = tonumber(hex:sub(1, 2), 16) / 255
	local g = tonumber(hex:sub(3, 4), 16) / 255
	local b = tonumber(hex:sub(5, 6), 16) / 255
	return { red = r, green = g, blue = b, alpha = alpha or 1 }
end

local function _updateBorder(self)
	local win = hs.window.focusedWindow()
	if not win or not win:isVisible() then
		_hideBorder(self)
		return
	end

	local f = win:frame()
	local bw = self.borderWidth
	f.x, f.y = f.x - bw, f.y - bw
	f.w, f.h = f.w + 2 * bw, f.h + 2 * bw

	if self._border then
		self._border:setFrame(f):show()
	else
		self._border = hs.drawing
			.rectangle(f)
			:setStrokeWidth(bw)
			:setStrokeColor(self.borderColor)
			:setRoundedRectRadii(self.cornerRadius, self.cornerRadius)
			:setFill(false)
			:setLevel(self.windowLevel)
			:show()
	end
end

function obj:start()
	if type(self.borderColor) == "string" then
		self.borderColor = hex2rgba(self.borderColor, self.borderAlpha or 1)
	elseif type(self.borderColor) == "table" and self.borderColor.hex then
		self.borderColor = hex2rgba(self.borderColor.hex, self.borderColor.alpha or 1)
	end

	self:_stopWatchers()

	self._winFilter = hs.window.filter.new()
	self._winFilter:subscribe({
		"windowFocused",
		"windowsChanged",
		"windowMoved",
		"windowVisible",
		"windowNotVisible",
		"windowFullscreened",
		"windowUnfullscreened",
	}, function()
		_updateBorder(self)
	end)

	self._spaceWatcher = hs.spaces.watcher
		.new(function()
			hs.timer.doAfter(0.05, function()
				_updateBorder(self)
			end)
		end)
		:start()

	_updateBorder(self)
	return self
end

function obj:stop()
	self:_stopWatchers()
	_hideBorder(self)
	return self
end

function obj:_stopWatchers()
	if self._winFilter then
		self._winFilter:unsubscribeAll()
		self._winFilter = nil
	end
	if self._spaceWatcher then
		self._spaceWatcher:stop()
		self._spaceWatcher = nil
	end
end

return obj
