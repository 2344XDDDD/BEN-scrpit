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
    Callback = function(value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end,
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
Tab:Divider()
local Toggle = Tab:Toggle({
    Title = "夜视",
    Default = false,
    Callback = function(Value) 
        if Value then

                game.Lighting.Ambient = Color3.new(1, 1, 1)

            else

                game.Lighting.Ambient = Color3.new(0, 0, 0)

            end
    end
})
local Toggle = Tab:Toggle({
    Title = "自动互动",
    Default = false,
    Callback = function(state) 
        if state then
            autoInteract = true
            while autoInteract do
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        fireproximityprompt(descendant)
                    end
                end
                task.wait(0.25) -- Adjust the wait time as needed
            end
        else
            autoInteract = false
        end
    end
})
local Toggle = Tab:Toggle({
    Title = "夜视",
    Default = false,
    Callback = function(Value) 
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end
})
