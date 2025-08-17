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

local FOVCircle = Instance.new('Frame')
FOVCircle.Name = 'FOV'
FOVCircle.Parent = ScreenGui
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.Size = UDim2.new(0, FOVRadius * 2, 0, FOVRadius * 2)
FOVCircle.BackgroundTransparency = 1

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
    Title = "启动 - FOV - 锁头",
    Default = false,
    Callback = function(Value) 
        AimbotEnabled = Value
        FOVCircle.Visible = Value
    end
})
