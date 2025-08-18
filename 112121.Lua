local Tab = Window:Tab({
    Title = '功能',
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
    Title = "无限跳",
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
local Toggle = Tab:Toggle({
    Title = "ESP",
    Default = false,
    Callback = function(state) 
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                end
            end
        end
    end
})
Tab:Divider()

local Button = Tab:Button({
    Title = "导管",
    Desc = "R15",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
    end
})

local Button = Tab:Button({
    Title = "导管",
    Desc = "R6",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end
})

Tab:Divider()
local Input = Tab:Input({
    Title = "自定义范围",
    Placeholder = "输入...",
    Callback = function(Value) 
   _G.HeadSize = Value
    _G.Disabled = true 
   game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
    pcall(function()
    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
   v.Character.HumanoidRootPart.Transparency = 0.7 
   v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
    v.Character.HumanoidRootPart.Material = "Neon"
    v.Character.HumanoidRootPart.CanCollide = false
    end)
    end 
   end 
   end
    end)
    end
})
