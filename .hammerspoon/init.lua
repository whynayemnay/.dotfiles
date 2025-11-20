hs.application.enableSpotlightForNameSearches(true)
-- Bind hotkeys to open and focus various apps
-- To find the name of the app use hs.application.find("name"):bundleID() in the console
local appBindings = {
    { key = "S", appName = "com.apple.Safari" },
    { key = "T", appName = "com.mitchellh.ghostty" },
    -- { key = "V", appName = "com.microsoft.VSCode" },
    { key = "G", appName = "com.openai.chat" },
    { key = "P", appName = "com.apple.Music" },
    { key = "F", appName = "org.mozilla.firefox" },
    { key = "D", appName = "com.hnc.Discord" },
    { key = "O", appName = "md.obsidian" },
    { key = "K", appName = "com.apple.iCal" },
    { key = "E", appName = "dev.zed.Zed" },
    -- { key = "E", appName = "org.gnu.Emacs" },
}

-- Bind the hotkeys for each app
for _, binding in ipairs(appBindings) do
    hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, binding.key, function()
        openOrFocusApp(binding.appName)
    end)
end

-- Bind hotkeys for window management
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "M", function() -- Maximize window
    maximizeWindow()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "N", function() -- Move to next monitor
    moveToNextMonitor()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "C", function()
    cycleWindows()
end)

-- Function to center the mouse in the focused window
function centerWindow()
    local win = hs.window.focusedWindow()
    if win then
        local frame = win:frame()
        hs.mouse.absolutePosition(hs.geometry.point(frame.x + frame.w / 2, frame.y + frame.h / 2))
    else
        hs.alert.show("No focused window")
    end
end

-- Function to maximize the current focused window
function maximizeWindow()
    hs.window.animationDuration = 0
    local win = hs.window.focusedWindow()
    if win then
        win:maximize()
    else
        hs.alert.show("No focused window to maximize")
    end
end

-- Function to move the current focused window to the next monitor
function moveToNextMonitor()
    hs.window.animationDuration = 0
    local win = hs.window.focusedWindow()
    if win then
        local currentScreen = win:screen()
        local nextScreen = currentScreen:next()
        if nextScreen then
            win:moveToScreen(nextScreen)
            -- centerWindow()
        else
            hs.alert.show("No next monitor found")
        end
    else
        hs.alert.show("No focused window to move")
    end
end

-- General function to launch or focus an application
function openOrFocusApp(appName)
    local app = hs.application.find(appName)
    if not app then
        hs.application.launchOrFocusByBundleID(appName)
    else
        app:activate()
    end

    -- Center the window after launching or focusing the app
    hs.timer.doAfter(0.05, function()
        -- centerWindow()
    end)
end

-- Function to cycle through windows of the same application
function cycleWindows()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("No active window")
        return
    end

    local app = win:application()
    if not app then
        return
    end

    local windows = app:allWindows()
    if #windows < 2 then
        hs.alert.show("Only one window open")
        return
    end

    -- Find the index of the currently focused window
    local currentIndex = nil
    for i, w in ipairs(windows) do
        if w == win then
            currentIndex = i
            break
        end
    end

    -- Cycle to the next window
    local nextIndex = (currentIndex % #windows) + 1
    local nextWin = windows[nextIndex]

    if nextWin then
        nextWin:focus()
        -- centerWindow()  -- Move cursor to new window
    end
end
