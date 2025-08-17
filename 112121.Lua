
local Tab = Window:Tab({
    Title = '脚本',
    Icon = 'bird',
    Locked = false,
})

local Button = Tab:Button({
    Title = "启动 - FOV - 脚本",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://github.com/2344XDDDD/BEN-scrpit/edit/main/FOV.LUA"))()
    end
})

local Tab = Window:Tab({
    Title = '功能',
    Icon = 'bird',
    Locked = false,
})

local Slider = Tab:Slider({
    Title = '速度',
    Step = 1,

    Value = {
        Min = 15,
        Max = 400,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})
local Slider = Tab:Slider({
    Title = '跳跃',
    Step = 1,

    Value = {
        Min = 50,
        Max = 400,
    },
    Callback = function(Jump)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump
    end,
})
local Slider = Tab:Slider({
    Title = '重力',
    Step = 1,

    Value = {
        Min = 196.2,
        Max = 400,
    },
    Callback = function(Value)
        game.Workspace.Gravity = Value
    end,
})
