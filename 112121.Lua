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
        Default = 15,
    },
    Callback = function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
local Slider = Tab:Slider({
    Title = "跳跃",
    Step = 1,
    
    Value = {
        Min = 50,
        Max = 400,
        Default = 50,
    },
    Callback = function(Jump)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump
    end
})
local Slider = Tab:Slider({
    Title = "重力",
    Step = 1,
    
    Value = {
        Min = 196,
        Max = 400,
        Default = 196,
    },
    Callback = function(Value)
    game.Workspace.Gravity = Value
    end
})
