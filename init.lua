--- === OutlineX_hs ===
---
--- Adds a configurable border around the focused *standard* window.
--- Excludes floating / system / utility windows automatically.
---
--- Usage:
---   local ox = hs.loadSpoon("OutlineX_hs")
---   ox.borderWidth  = 6
---   ox.borderColor  = "#FF8800"      -- HEX string or RGBA table
---   ox.cornerRadius = 10
---   ox:start()

-------------------------------------------------------------------
-- Spoon Object
-------------------------------------------------------------------
local outlineX_hs = {}
outlineX_hs.__index = outlineX_hs

-- ▸ Metadata ------------------------------------------------------
outlineX_hs.name = "OutlineX_hs"
outlineX_hs.version = "1.2"
outlineX_hs.author = "d7man <di7@hotmail.com>"
outlineX_hs.homepage = "https://github.com/x0d7x/outlineX-hs"

-- ▸ Default Settings ---------------------------------------------
outlineX_hs.borderWidth = 4
outlineX_hs.borderColor = { red = 0.20, green = 0.55, blue = 1.00, alpha = 0.90 }
outlineX_hs.cornerRadius = 6
outlineX_hs.windowLevel = "overlay" -- or "assistiveTechHigh"
outlineX_hs.borderAlpha = nil -- optional override when using HEX

-- ▸ Internals -----------------------------------------------------
outlineX_hs._border = nil
outlineX_hs._winFilter = nil
outlineX_hs._spaceWatcher = nil

-------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------
local function _hideBorder(self)
	if self._border then
		self._border:hide()
	end
end

--- Convert "#RRGGBB" or "#RGB" to {red,green,blue,alpha}
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

--- Draw / move border
local function _updateBorder(self)
	local win = hs.window.focusedWindow()
	if not win or not win:isVisible() or not win:isStandard() then
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

function outlineX_hs:start()
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

function outlineX_hs:stop()
	self:_stopWatchers()
	_hideBorder(self)
	return self
end

function outlineX_hs:_stopWatchers()
	if self._winFilter then
		self._winFilter:unsubscribeAll()
		self._winFilter = nil
	end
	if self._spaceWatcher then
		self._spaceWatcher:stop()
		self._spaceWatcher = nil
	end
end

return outlineX_hs
