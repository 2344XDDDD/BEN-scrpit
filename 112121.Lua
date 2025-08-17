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
        StatsLabel.Text = ''
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

-- Highlight
local function ApplyHighlight(player)
    if not player.Character then
        return
    end
    local existing = player.Character:FindFirstChild('ESPHighlight')
    if existing then
        existing:Destroy()
    end

    local highlight = Instance.new('Highlight')
    highlight.Name = 'ESPHighlight'
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = HighlightColor
    highlight.FillColor = HighlightColor
    highlight.Enabled = ESPEnabled
        and (not ESPTeamCheck or player.Team ~= LocalPlayer.Team)
    highlight.Parent = player.Character
end

local function SetupCharacterHighlight(player)
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            repeat
                task.wait()
            until player.Character
                and player.Character:FindFirstChild('HumanoidRootPart')
            ApplyHighlight(player)
        end)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    SetupCharacterHighlight(player)
    if player.Character then
        ApplyHighlight(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    SetupCharacterHighlight(player)
end)

-- Aimbot
local function GetClosestTarget()
    local closest = nil
    local shortestDist = FOVRadius

    for _, player in ipairs(Players:GetPlayers()) do
        if
            player ~= LocalPlayer
            and player.Character
            and player.Character:FindFirstChild('HumanoidRootPart')
        then
            if TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end

            local pos, onScreen = Camera:WorldToViewportPoint(
                player.Character.HumanoidRootPart.Position
            )
            if onScreen then
                local center = Vector2.new(
                    Camera.ViewportSize.X / 2,
                    Camera.ViewportSize.Y / 2
                )
                local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude

                if dist <= shortestDist then
                    if WallCheck then
                        local origin = Camera.CFrame.Position
                        local direction = (
                            player.Character.HumanoidRootPart.Position - origin
                        ).Unit * 1000
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterDescendantsInstances =
                            { LocalPlayer.Character }
                        raycastParams.FilterType =
                            Enum.RaycastFilterType.Blacklist

                        local result =
                            workspace:Raycast(origin, direction, raycastParams)
                        if
                            result
                            and result.Instance:IsDescendantOf(player.Character)
                        then
                            closest = player
                            shortestDist = dist
                        end
                    else
                        closest = player
                        shortestDist = dist
                    end
                end
            end
        end
    end

    return closest
end

RunService.RenderStepped:Connect(function()
    if FOVRainbow then
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 1, 1)
        UIStroke.Color = color
    end

    if AimbotEnabled then
        local target = GetClosestTarget()
        if
            target
            and target.Character
            and target.Character:FindFirstChild('HumanoidRootPart')
        then
            local head = target.Character.HumanoidRootPart.Position
            local camPos = Camera.CFrame.Position
            local newCF = CFrame.new(camPos, head)
            Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.4)
        end
    end
end)
