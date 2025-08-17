local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local HttpService = game:GetService('HttpService')
local TweenService = game:GetService('TweenService')

-- Config
local AimbotEnabled = false
local TeamCheck = false
local WallCheck = false
local FOVRadius = 100
local ESPEnabled = false
local ESPTeamCheck = false
local HighlightColor = Color3.fromRGB(255, 0, 0)
local FOVRainbow = false
local FOVColor = Color3.fromRGB(0, 255, 0)

-- FOV Circle
local ScreenGui = Instance.new('ScreenGui', game.CoreGui)
ScreenGui.IgnoreGuiInset = false
ScreenGui.ResetOnSpawn = false

local UIStroke = Instance.new('UIStroke', FOVCircle)
UIStroke.Thickness = 2
UIStroke.Color = FOVColor

local UICorner = Instance.new('UICorner', FOVCircle)
UICorner.CornerRadius = UDim.new(1, 0)

-- FPS y Ping Display
local StatsLabel = Instance.new('TextLabel')
StatsLabel.Parent = ScreenGui
StatsLabel.Size = UDim2.new(0, 200, 0, 50)
StatsLabel.Position = UDim2.new(1, -210, 0, 10)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.new(1, 1, 1)
StatsLabel.TextStrokeTransparency = 0
StatsLabel.Font = Enum.Font.Code
StatsLabel.TextSize = 18
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right

local lastUpdate = tick()


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
Window:Divider()
local Tab = Window:Tab({
    Title = 'FOV',
    Icon = 'bird',
    Locked = false,
})

local Toggle = Tab:Toggle({
    Title = "启动 - 团队检查",
    Default = false,
    Callback = function(value) 
TeamCheck = value
    end
})

local Toggle = Tab:Toggle({
    Title = "启动 - 墙面检查",
    Default = false,
    Callback = function(value) 
WallCheck = value
    end
})

local Slider = Tab:Slider({
    Title = 'FOV - 尺寸',
    Step = 1,

    Value = {
        Min = 50,
        Max = 300,
    },
    Callback = function(value)
        FOVRadius = value
        FOVCircle.Size = UDim2.new(0, value * 2, 0, value * 2)
    end,
})
Window:Divider()
local Tab = Window:Tab({
    Title = 'ESP',
    Icon = 'bird',
    Locked = false,
})

local Toggle = Tab:Toggle({
    Title = "启动 - 突出显示",
    Default = false,
    Callback = function(value) 
     ESPEnabled = value
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local highlight = player.Character
                    and player.Character:FindFirstChild('ESPHighlight')
                if highlight then
                    highlight.Enabled = value
                        and (
                            not ESPTeamCheck
                            or player.Team ~= LocalPlayer.Team
                        )
                end
            end
        end
    end
})

local Toggle = Tab:Toggle({
    Title = "启动 - 团队检查亮点",
    Default = false,
    Callback = function(value) 
     ESPEnabled = value
    ESPTeamCheck = value
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local highlight = player.Character
                    and player.Character:FindFirstChild('ESPHighlight')
                if highlight then
                    highlight.Enabled = ESPEnabled
                        and (not value or player.Team ~= LocalPlayer.Team)
                end
            end
        end
    end
})

local Colorpicker = Tab:Colorpicker({
    Title = "高亮颜色",
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(value) 
            HighlightColor = value
        for _, player in ipairs(Players:GetPlayers()) do
            local highlight = player.Character
                and player.Character:FindFirstChild('ESPHighlight')
            if highlight then
                highlight.OutlineColor = value
                highlight.FillColor = value
            end
        end
    end
})
Window:Divider()
local Tab = Window:Tab({
    Title = 'Visual',
    Icon = 'bird',
    Locked = false,
})

local Colorpicker = Tab:Colorpicker({
    Title = "FOV - 颜色",
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0,
    Locked = false,
    Callback = function(value) 
        FOVColor = value
        if not FOVRainbow then
            UIStroke.Color = value
    end
})

