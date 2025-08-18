local Tab = Window:Tab({
    Title = '功能',
    Icon = 'bird',
    Locked = false,
})

local Slider = Tab:Slider({
    Title = "速度",
    Step = 1,
    
    Value = {
        Min = 15,
        Max = 400,
    },
    Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end,
})
local Slider = Tab:Slider({
    Title = "跳跃",
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
    Title = "重力",
    Step = 1,
    
    Value = {
        Min = 196,
        Max = 400,
    },
    Callback = function(Value)
    game.Workspace.Gravity = Value
    end,
})
local Slider = Tab:Slider({
    Title = "视野",
    Step = 1,
    
    Value = {
        Min = 70,
        Max = 240,
    },
    Callback = function(v)
       game.Workspace.CurrentCamera.FieldOfView = v
    end,
})
local Slider = Tab:Slider({
    Title = "视角拉长最大",
    Step = 1,
    
    Value = {
        Min = 128,
        Max = 10000,
    },
    Callback = function(Value)
     game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
    end,
})
