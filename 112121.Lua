
Window:Divider()
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
Tab:Divider()
local Toggle = Tab:Toggle({
    Title = "夜视",
    Desc = "Toggle Description",
    Type = "Checkbox",
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
local Button = Tab:Button({
    Title = "范围",
    Desc = "普通",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jiNwDbCN"))()
    end
})
local Button = Tab:Button({
    Title = "范围",
    Desc = "中等",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jiNwDbCN"))()
    end
})
local Button = Tab:Button({
    Title = "范围",
    Desc = "全图",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KKY9EpZU"))()
    end
})
local Button = Tab:Button({
    Title = "范围",
    Desc = "终极",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/CAQ9x4A7"))()
    end
})
Tab:Divider()
local Button = Tab:Button({
    Title = "自瞄",
    Desc = "200",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/b5CuDuer/raw",true))()
    end
})
local Button = Tab:Button({
    Title = "自瞄",
    Desc = "300",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/nIyVhrvV/raw",true))()
    end
})
local Button = Tab:Button({
    Title = "自瞄",
    Desc = "400",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/LQuP7sjj/raw",true))()
    end
})
local Button = Tab:Button({
    Title = "自瞄",
    Desc = "脚本",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
    end
})
Window:Divider()
local Tab = Window:Tab({
    Title = 'FOV',
    Locked = false,
})
local Toggle = Tab:Toggle({
    Title = "FOV",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        FOVCircle.Visible = state
        if not state and lockEnabled then
            lockEnabled = false
            LockToggle:Set(false)
        end
    end
})

local Colorpicker = Tab:Colorpicker({
    Title = "FOV设置颜色",
    Desc = "设置FOV颜色",
    Default = circleColor,
    Callback = function(color)
        circleColor = color
        stroke.Color = color
    end
})

local Slider = Tab:Slider({
    Title = "FOV设置大小",
    Step = 1,
    Value = { Min = 50, Max = 300, Default = circleRadius },
    Callback = function(value)
        circleRadius = value
        FOVCircle.Size = UDim2.new(0, circleRadius*2, 0, circleRadius*2)
        FOVCircle.Position = UDim2.new(0.5, -circleRadius, 0.5, -circleRadius)
    end
})

local Slider = Tab:Slider({
    Title = "锁头力度",
    Step = 1,
    Value = { Min = 1, Max = 100, Default = 15 },
    Callback = function(value)
        LockSmoothness = value / 100
    end
})
local Dropdown = Tab:Dropdown({
    Title = "锁定部位",
    Values = { "头部", "身体", "左手", "右手" },
    Value =  "头部" ,
    Callback = function(selected)
        LockTarget.Head = false
        LockTarget.Torso = false
        LockTarget.LeftHand = false
        LockTarget.RightHand = false
        
        for _, part in pairs(selected) do
            if part == "头部" then LockTarget.Head = true
            elseif part == "身体" then LockTarget.Torso = true
            elseif part == "左手" then LockTarget.LeftHand = true
            elseif part == "右手" then LockTarget.RightHand = true
            end
        end
    end
})

local Button = Tab:Toggle({
    Title = "锁头",
    Desc = "鼠标右击",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        if state then
            if not FOVCircle.Visible then
                WindUI:Notify({ 
                    Title = '通知',
                    Content = '请开启FOV',
                    Duration = 3,
                })
                LockToggle:Set(false)
                lockEnabled = false
                return
            else
                lockEnabled = true
            end
        else
            lockEnabled = false
        end
    end
})

local Button = Tab:Connect(function()
    if lockEnabled and FOVCircle.Visible and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local closest, dist = nil, FOVCircle.Size.X.Offset / 2
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local partToLock = nil
                if LockTarget.Head and plr.Character:FindFirstChild("Head") then
                    partToLock = plr.Character.Head
                elseif LockTarget.Torso and plr.Character:FindFirstChild("HumanoidRootPart") then
                    partToLock = plr.Character.HumanoidRootPart
                elseif LockTarget.LeftHand and plr.Character:FindFirstChild("LeftHand") then
                    partToLock = plr.Character.LeftHand
                elseif LockTarget.RightHand and plr.Character:FindFirstChild("RightHand") then
                    partToLock = plr.Character.RightHand
                end
                
                if partToLock then
                    local pos, onScreen = camera:WorldToViewportPoint(partToLock.Position)
                    if onScreen then
                        local screenCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                        local d = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                        if d < dist then
                            dist = d
                            closest = partToLock
                        end
                    end
                end
            end
        end

        if closest then
            local targetPos = camera:WorldToViewportPoint(closest.Position)
            local screenCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
            local delta = Vector2.new(targetPos.X, targetPos.Y) - screenCenter
            local move = getrenv().mousemoverel or mousemoverel
            if move then
                move(delta.X * LockSmoothness, delta.Y * LockSmoothness)
            end
        end
    end
end)
Tab:Divider()

local Tab = Window:Tab({
    Title = '脚本',
    Locked = false,
})
local Button = Tab:Button({
    Title = "BENG-SCRIPT-版本选择V2",
    Desc = "脚本",
    Locked = false,
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/2344XDDDD/BEN-scrpit/refs/heads/main/BENG-PLAY!-V1"))()
    end
})
Window:Divider()
local Tab = Window:Tab({
    Title = '杂项 - 设置',
    Locked = false,
})
Window:Divider()
local transparencySlider = Tab:Slider({
    Title = "设置 - UI:透明度",
    Value = { 
        Min = 0,
        Max = 1,    
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())
