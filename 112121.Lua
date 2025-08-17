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

local lastUpdate = tick()
RunService.RenderStepped:Connect(function()
    local fps = math.floor(1 / RunService.RenderStepped:Wait())
    if tick() - lastUpdate >= 0.3 then
        local ping = tonumber(
            string.match(
                game:GetService('Stats').Network.ServerStatsItem['Data Ping']
                    :GetValueString(),
                '%d+'
            )
        ) or 0
        lastUpdate = tick()
    end
end)


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

local Toggle = Tab:Toggle({
    Title = "FOV - 彩虹",
    Default = false,
    Callback = function(value) 
        FOVRainbow = value
    end
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

local Toggle = Tab:Toggle({
    Title = "慢动作 PvP",
    Default = false,
    Callback = function(enabled) 
       if enabled then
            local tween = TweenService:Create(
                game,
                TweenInfo.new(0.5),
                { ClockTime = 0.25 }
            )
            tween:Play()
            game:GetService('RunService'):Set3dRenderingEnabled(true)
            workspace.Gravity = 100 -- Menos gravedad ayuda al efecto
        else
            local tween =
                TweenService:Create(game, TweenInfo.new(0.5), { ClockTime = 1 })
            tween:Play()
            workspace.Gravity = 196.2 -- Gravedad por defecto
        end
    end
})

local Lighting = game:GetService('Lighting')
local StarsGui
local OriginalAmbient = Lighting.Ambient
local OriginalOutdoorAmbient = Lighting.OutdoorAmbient
local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalSky = Lighting:FindFirstChildOfClass('Sky')

local Toggle = Tab:Toggle({
    Title = "软 PvP 天堂模式",
    Default = false,
    Callback = function(value) 
    if value then
            -- Ajustes suaves de luz (crepúsculo)
            Lighting.Ambient = Color3.fromRGB(120, 130, 140)
            Lighting.OutdoorAmbient = Color3.fromRGB(90, 100, 110)
            Lighting.Brightness = 1.5
            Lighting.ClockTime = 18.5 -- atardecer muy suave

            -- Cambiar cielo por uno con estrellas
            if OriginalSky then
                OriginalSky.Enabled = false
            end
            local PvPSky = Instance.new('Sky')
            PvPSky.Name = 'PvPSky'
            PvPSky.SkyboxBk = 'rbxassetid://1022207611' -- ejemplo cielo estrellado, cambia por uno que te guste
            PvPSky.SkyboxDn = 'rbxassetid://1022207683'
            PvPSky.SkyboxFt = 'rbxassetid://1022207746'
            PvPSky.SkyboxLf = 'rbxassetid://1022207814'
            PvPSky.SkyboxRt = 'rbxassetid://1022207886'
            PvPSky.SkyboxUp = 'rbxassetid://1022207958'
            PvPSky.Parent = Lighting

            -- Estrellas sutiles en ScreenGui
            StarsGui = Instance.new('ScreenGui', game.CoreGui)
            StarsGui.Name = 'StarsGui'
            StarsGui.IgnoreGuiInset = true
            StarsGui.ResetOnSpawn = false

            for i = 1, 50 do
                local star = Instance.new('Frame')
                star.Size = UDim2.new(0, 2, 0, 2)
                star.Position = UDim2.new(math.random(), 0, math.random(), 0)
                star.BackgroundColor3 = Color3.new(1, 1, 1)
                star.BackgroundTransparency = 0.7
                star.BorderSizePixel = 0
                star.AnchorPoint = Vector2.new(0.5, 0.5)
                star.Parent = StarsGui

                coroutine.wrap(function()
                    while StarsGui and StarsGui.Parent do
                        star.BackgroundTransparency = 0.5
                            + math.sin(tick() * math.random(1, 3)) * 0.4
                        wait(0.1)
                    end
                end)()
            end
        else
            -- Restaurar valores originales
            Lighting.Ambient = OriginalAmbient
            Lighting.OutdoorAmbient = OriginalOutdoorAmbient
            Lighting.Brightness = OriginalBrightness
            Lighting.ClockTime = OriginalClockTime

            local PvPSky = Lighting:FindFirstChild('PvPSky')
            if PvPSky then
                PvPSky:Destroy()
            end
            if OriginalSky then
                OriginalSky.Enabled = true
            end

            if StarsGui then
                StarsGui:Destroy()
                StarsGui = nil
            end
        end
    end
})

local OptimTab = Window:CreateTab('Optimización', 4483362458)
