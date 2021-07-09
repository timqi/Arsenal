config = {
    default_hold_seconds = 0,
    pause_seconds_after_cancel = 0.1,
    default_wait_seconds = 0.3,
    alert_style = {
        -- http://www.hammerspoon.org/docs/hs.alert.html#defaultStyle
        fillColor = {white = 0, alpha = 0.9},
        strokeColor = {white = 1, alpha = 0.3},
        textColor = {white = 1, alpha = 0.9},
        textFont = "Menlo",
        textSize = 18,
        radius = 5
    }
}

local right_cmd_to_f13 = [[hidutil property --set '{"UserKeyMapping": [{"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x700000068}, {"HIDKeyboardModifierMappingSrc":0x7000000e6, "HIDKeyboardModifierMappingDst":0x700000069}] }']]
local result = os.execute(right_cmd_to_f13)
hs.alert.show("Remaped", config.alert_style, hs.screen.mainScreen(), 1)

f13 = {
    key = "f13",
    {key = "s", app = "Slack"},
    {key = "d", app = "DingTalk"},
    {key = "a", app = "Alacritty"},
    {key = "t", app = "iTerm", apps = {"Terminal"}},
    {key = "e", app = "Eudb_en"},
    {key = "c", app = "Google Chrome"},
    {key = "v", app = "Visual Studio Code"},
    {key = "w", app = "WeChat"},
    {key = "z", app = "zoom.us"},
    {key = "n", app = "Notion"}
}

local confActive
local holdingListener
holdingListener =
    hs.eventtap.new(
    {hs.eventtap.event.types.keyDown},
    function(event)
        local keyCode = event:getKeyCode()
        local key = hs.keycodes.map[keyCode]
        if confActive == nil then
            holdingListener:stop()
            return
        end
        if key ~= confActive.key then
            if not confActive.stroked then
                confActive.stroked = true
                holdingListener:stop()
                local stroke = confActive.key
                confActive:cancel()
                return true, {
                    hs.eventtap.event.newKeyEvent({}, stroke, true),
                    hs.eventtap.event.newKeyEvent({}, key, true)
                }
            end
        end
        return true
    end
)

local launchers = {}
local function runLauncher(conf)
    local hots = {}
    local alert = "LAUNCHER " .. conf.key
    local alertID
    for _, info in ipairs(conf) do
        local k
        local rep
        if info.app then
            k = function()
                if not hs.application.launchOrFocus(info.app) then
                    local fail = true
                    if info.apps then
                        for _, app in ipairs(info.apps) do
                            print("try", app)
                            if hs.application.launchOrFocus(app) then
                                fail = false
                                break
                            end
                        end
                    end
                    if fail then
                        hs.notify.show("App launch failed", info.app, "")
                    end
                end
            end
            alert = alert .. "\n" .. info.key .. ": " .. info.app
            if info.apps then
                alert = alert .. " or " .. info.apps[1]
            end
        elseif info.character then
            k = function()
                hs.eventtap.keyStroke(info.modifiers, info.character)
            end
            rep = k
            alert = alert .. "\n" .. info.key .. ": key "
            if #info.modifiers > 0 then
                alert = alert .. table.concat(info.modifiers, "+") .. " "
            end
            alert = alert .. info.character
        elseif info.exec then
            k = function()
                local result = os.execute(info.exec)
                if result then
                    result = "success"
                end
                if info.notify then
                    hs.notify.new({title = "execute " .. tostring(result), informativeText = info.exec}):send()
                end
            end
            alert = alert .. "\n" .. info.key .. ": "
            if info.desc then
                alert = alert .. info.desc
            else
                alert = alert .. "execute"
            end
        else
            k = info.func
            alert = alert .. "\n" .. info.key .. ": "
            if info.desc then
                alert = alert .. info.desc
            else
                alert = alert .. "function"
            end
        end
        hots[#hots + 1] = hs.hotkey.new({}, info.key, k, nil, rep)
    end
    -- acitons
    local trigger
    local function press()
        if conf.triggered or confActive or conf.triggerTimer then
            return
        end
        for _, l in ipairs(launchers) do
            if l.key ~= conf.key then
                l.obj:disable()
            end
        end
        conf.triggerTimer = hs.timer.doAfter(config.default_hold_seconds, trigger)
        confActive = conf
        holdingListener:start()
    end
    trigger = function()
        if confActive ~= conf then
            return
        end
        if not conf.triggered then
            conf.triggered = true
            alertID = hs.alert.show(alert, config.alert_style, hs.screen.mainScreen(), true)
            holdingListener:stop()
            for _, hotkey in ipairs(hots) do
                hotkey:enable()
            end
        end
        conf.triggerTimer = nil
    end
    local function cancel()
        if conf.triggerTimer then
            conf.triggerTimer:stop()
            conf.triggerTimer = nil
        end
        if confActive ~= conf then
            return
        end
        -- waitingListener:stop()
        confActive = {}
        if conf.triggered then
            for _, hotkey in ipairs(hots) do
                hotkey:disable()
            end
            hs.alert.closeSpecific(alertID)
        end
        if not conf.triggered then
            for _, l in ipairs(launchers) do
                l.obj:disable()
            end
            holdingListener:stop()
            if not conf.stroked then
                hs.eventtap.keyStroke({}, conf.key)
            end
        end
        holdingListener:stop()
        conf.triggered = nil
        conf.stroked = nil
        hs.timer.doAfter(
            config.pause_seconds_after_cancel,
            function()
                confActive = nil
                for _, l in ipairs(launchers) do
                    l.obj:enable()
                end
            end
        )
    end
    conf.cancel = cancel
    local launcher = hs.hotkey.bind({}, conf.key, press, cancel)
    launchers[#launchers + 1] = {
        key = conf.key,
        obj = launcher
    }
end

runLauncher(f13)


-- MiroWindowsManager https://github.com/miromannino/miro-windows-manager
local hyper = {"alt", "cmd"}
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.1
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})
