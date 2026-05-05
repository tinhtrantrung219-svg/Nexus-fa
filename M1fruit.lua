getgenv().team = "Pirates"

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")

if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
        local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes")
        l_Remotes_0.CommF_:InvokeServer("SetTeam", getgenv().team)
        task.wait(3)
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end

repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")

local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ImageWithBlur"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 24
blurEffect.Parent = game:GetService("Lighting")

local containerFrame = Instance.new("Frame")
containerFrame.Size = UDim2.new(1, 0, 1, 0)
containerFrame.Position = UDim2.new(0, 0, 1, 0)
containerFrame.BackgroundTransparency = 1
containerFrame.Parent = screenGui

local transparentFrame = Instance.new("Frame")
transparentFrame.Size = UDim2.new(1, 0, 1, 0)
transparentFrame.BackgroundTransparency = 1
transparentFrame.Parent = containerFrame

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 170, 0, 170)
imageLabel.Position = UDim2.new(0.5, -100, 0.5, -120)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://129934580298278"
imageLabel.Parent = containerFrame
imageLabel.Visible = false

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0, 200, 0, 20)
timeLabel.Position = UDim2.new(0.5, -100, 0.5, 155)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
timeLabel.TextScaled = true
timeLabel.Font = Enum.Font.GothamBold
timeLabel.Text = "00 Hour (h) 00 Minute (m) 00 Second (s)"
timeLabel.Parent = containerFrame

-- Branding
local lixuryxLabel = Instance.new("TextLabel")
lixuryxLabel.Size = UDim2.new(0, 300, 0, 40)
lixuryxLabel.Position = UDim2.new(0.5, -150, 0.5, -170)
lixuryxLabel.BackgroundTransparency = 1
lixuryxLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
lixuryxLabel.TextScaled = true
lixuryxLabel.Font = Enum.Font.GothamBold
lixuryxLabel.Text = "Drex Hub | Auto Bounty"
lixuryxLabel.Parent = containerFrame

-- Premium-Hinweis
local premiumLabel = Instance.new("TextLabel")
premiumLabel.Size = UDim2.new(0, 90, 0, 15)
premiumLabel.Position = UDim2.new(0.5, 125, 0.5, -200)
premiumLabel.BackgroundTransparency = 1
premiumLabel.TextColor3 = Color3.fromRGB(230, 230, 255)
premiumLabel.TextScaled = true
premiumLabel.Font = Enum.Font.GothamBold
premiumLabel.Text = "[Freemium]"
premiumLabel.Parent = containerFrame
premiumLabel.Visible = false

-- Discord-Label
local discordLabel = Instance.new("TextLabel")
discordLabel.Size = UDim2.new(0, 120, 0, 10)
discordLabel.Position = UDim2.new(0.5, -63, 0.5, 150)
discordLabel.BackgroundTransparency = 1
discordLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
discordLabel.TextScaled = true
discordLabel.Font = Enum.Font.GothamBold
discordLabel.Text = "https://discord.gg/HGM2exC2"
discordLabel.Parent = containerFrame

-- Spielername oben rechts
local playerNameLabel = Instance.new("TextLabel")
playerNameLabel.Size = UDim2.new(0, 80, 0, 8)
playerNameLabel.Position = UDim2.new(1, -85, 0, -50)
playerNameLabel.BackgroundTransparency = 1
playerNameLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
playerNameLabel.TextScaled = true
playerNameLabel.Font = Enum.Font.GothamBold
playerNameLabel.TextXAlignment = Enum.TextXAlignment.Right
playerNameLabel.Text = "(" .. player.Name ..")"
playerNameLabel.Parent = containerFrame

-- Bounty-Anzeige
local bountyLabel = Instance.new("TextLabel")
bountyLabel.Size = UDim2.new(0, 240, 0, 18)
bountyLabel.Position = UDim2.new(0.5, -120, 0.5, -125)
bountyLabel.BackgroundTransparency = 1
bountyLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
bountyLabel.TextScaled = true
bountyLabel.Font = Enum.Font.GothamBold
bountyLabel.TextXAlignment = Enum.TextXAlignment.Center
bountyLabel.Text = "Bounty: 0"
bountyLabel.Parent = containerFrame

-- Kill-Zähler
local killsLabel = Instance.new("TextLabel")
killsLabel.Size = UDim2.new(0, 240, 0, 18)
killsLabel.Position = UDim2.new(0.5, -120, 0.5, -102)
killsLabel.BackgroundTransparency = 1
killsLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
killsLabel.TextScaled = true
killsLabel.Font = Enum.Font.GothamBold
killsLabel.TextXAlignment = Enum.TextXAlignment.Center
killsLabel.Text = "Kills: 0"
killsLabel.Parent = containerFrame

-- Tween-Animation von unten nach oben
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local goal = { Position = UDim2.new(0, 0, 0, 0) }
local tween = TweenService:Create(containerFrame, tweenInfo, goal)
tween:Play()

local startTime = tick()
getgenv().sessionKills = getgenv().sessionKills or 0
tween.Completed:Connect(function()
    -- Aktualisiere UI-Elemente jede Sekunde
    task.spawn(function()
        while screenGui.Parent do
            local elapsed = math.floor(tick() - startTime)
            local hours = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local seconds = elapsed % 60
            timeLabel.Text = string.format("%02d Hour (h) %02d Minute (m) %02d Second (s)", hours, minutes, seconds)
            local leaderstats = game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats")
            local bountyStat = leaderstats and leaderstats:FindFirstChild("Bounty/Honor")
            if bountyStat then
                bountyLabel.Text = "Bounty: " .. tostring(bountyStat.Value)
            else
                bountyLabel.Text = "Bounty: N/A"
            end
            killsLabel.Text = "Kills: " .. tostring(getgenv().sessionKills or 0)
            task.wait(1)
        end
    end)
end)

-- --> Standard-Einstellungen falls nicht vorhanden
if not getgenv().Setting then
    getgenv().Setting = {
        ["YOU"] = {
            ["Team"] = getgenv().team or "Pirates",
        },
        ["Webhook"] = {
            ["Enabled"] = true,
            ["Url"] = ""
        },
        ["Chat"] = {
            ["Enabled"] = false,
            ["List"] = {"Zynex hub [Skid]"},
        }
    }
end

if not getgenv().Setting.Melee then
    getgenv().Setting.Melee = {
        ["Enable"] = true,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["C"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["Delay"] = 1.5
    }
end

if not getgenv().Setting.Sword then
    getgenv().Setting.Sword = {
        ["Enable"] = true,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["Delay"] = 1
    }
end

if not getgenv().Setting.Gun then
    getgenv().Setting.Gun = {
        ["Enable"] = true,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["Delay"] = 1,
        ["GunMode"] = false
    }
end

if not getgenv().Setting.Fruit then
    getgenv().Setting.Fruit = {
        ["Enable"] = true,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["C"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["V"] = {["Enable"] = false, ["HoldTime"] = 0.1},
        ["F"] = {["Enable"] = true, ["HoldTime"] = 0.1},
        ["Delay"] = 1
    }
end

if not getgenv().Setting.Click then
    getgenv().Setting.Click = {
        ["FastClick"] = true,
        ["AlwaysClick"] = true
    }
end

if not getgenv().Setting.Hunt then
    getgenv().Setting.Hunt = {
        ["Min"] = 0,
        ["Max"] = 30000000
    }
end

if not getgenv().Setting.Skip then
    getgenv().Setting.Skip = {
        ["V4"] = true,
        ["Fruit"] = false,
        ["FruitList"] = {"Buddha", "Leopard", "T-Rex"},
        ["SafeZone"] = true,
        ["NoHaki"] = true,
        ["NoPvP"] = true
    }
end

if not getgenv().Setting.SafeHealth then
    getgenv().Setting.SafeHealth = {
        ["Health"] = 7000,
        ["Mask"] = false,
        ["MaskType"] = "Mask",
        ["RaceV4"] = false
    }
end

if not getgenv().Setting.Another then
    getgenv().Setting.Another = {
        ["V3"] = true,
        ["V4"] = true,
        ["CustomHealth"] = true,
        ["Health"] = 7000,
        ["WhiteScreen"] = false,
        ["FPSBoots"] = false,
        ["LockCamera"] = false,
        ["AutoServerHop"] = true,
        ["HopWhenNoBounty"] = true,
        ["BountyLock"] = false,
        ["BountyLockAt"] = 30000000,
        ["ServerHopAfterTime"] = false,
        ["ServerHopTime"] = 900,
        ["CheckCombatBeforeHop"] = true,
        ["MaxPlayersInServer"] = 8,
        ["LoopDelay"] = 0.12,
        ["SlowLoopDelay"] = 0.2
    }
end

if getgenv().Setting.Another.LoopDelay == nil then
    getgenv().Setting.Another.LoopDelay = 0.12
end
if getgenv().Setting.Another.SlowLoopDelay == nil then
    getgenv().Setting.Another.SlowLoopDelay = 0.2
end

-- --> NEU: Bewegungseinstellungen (sanft, konfigurierbar)
if not getgenv().Setting.Movement then
    getgenv().Setting.Movement = {
        ["Enable"] = true,   -- wenn true, wird sanft bewegt statt zu teleportieren
        ["Speed"] = 300       -- Geschwindigkeit (auf 300 erhöht wie gewünscht)
    }
end
-- Globale Variablen
getgenv().weapon = nil
getgenv().targ = nil
getgenv().lasttarrget = nil
getgenv().checked = {}
getgenv().killed = nil

-- Welt-/Insel-Konfiguration
local placeId = game.PlaceId
local worldMap = {
    [2753915549] = true,
    [4442272183] = true,
    [100117331123089] = true
}
if worldMap[placeId] then
    if placeId == 2753915549 then
        World1 = true
    elseif placeId == 4442272183 then
        World2 = true
    elseif placeId == 100117331123089 then
        World3 = true
    end
else
    game:GetService("Players").LocalPlayer:Kick("Not Support Game")
end

-- Inselpositionen je nach Welt
local distbyp, island
if World3 then
    distbyp = 10000 -- Erhöht, um Reset-Schleifen zu verhindern
    island = {
        ["Port Town"] = CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375),
        ["Hydra Island"] = CFrame.new(5749.7861328125 + 50, 611.9736938476562, -276.2497863769531),
        ["Mansion"] = CFrame.new(-12471.169921875 + 50, 374.94024658203, -7551.677734375),
        ["Castle On The Sea"] = CFrame.new(-5085.23681640625 + 50, 316.5072021484375, -3156.202880859375),
        ["Haunted Island"] = CFrame.new(-9547.5703125, 141.0137481689453, 5535.16162109375),
        ["Great Tree"] = CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625),
        ["Candy Island"] = CFrame.new(-1106.076416015625, 13.016114234924316, -14231.9990234375),
        ["Cake Island"] = CFrame.new(-1903.6856689453125, 36.70722579956055, -11857.265625),
        ["Loaf Island"] = CFrame.new(-889.8325805664062, 64.72842407226562, -10895.8876953125),
        ["Peanut Island"] = CFrame.new(-1943.59716796875, 37.012996673583984, -10288.01171875),
        ["Cocoa Island"] = CFrame.new(147.35205078125, 23.642955780029297, -12030.5498046875),
        ["Tiki Outpost"] = CFrame.new(-16234,9,416)
    }
elseif World2 then
    distbyp = 10000
    island = {
        a = CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938),
        b = CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094),
        c = CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375),
        d = CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344),
        e = CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828),
        f = CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875),
        g = CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188),
        h = CFrame.new(923.40197753906, 125.05712890625, 32885.875),
        i = CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125),
    }
elseif World1 then
    distbyp = 10000
    island = {
        a = CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594),
        b = CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156),
        c = CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688),
        d = CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969),
        e = CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754),
        f = CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094),
        g = CFrame.new(-4607.82275, 872.54248, -1667.55688),
        h = CFrame.new(-7952.31006, 5545.52832, -320.704956),
        i = CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313),
        j = CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969),
        k = CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469),
        l = CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813),
        m = CFrame.new(61163.8515625, 11.6796875, 1819.7841796875),
        n = CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875),
        o = CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656),
        p = CFrame.new(-4813.0249, 903.708557, -1912.69055),
        q = CFrame.new(-4970.21875, 717.707275, -2622.35449),
    }
end

-- Hilfsvariablen
local p = game.Players
local lp = p.LocalPlayer
local rs = game:GetService("RunService")
local hb = rs.Heartbeat
local rends = rs.RenderStepped
local webhook = {}

-- Drosselungswerte (auf 0.34 gesetzt wie gewünscht)
local FAST_LOOP_DELAY = 0.34
local SLOW_LOOP_DELAY = 0.34
local lastKillTick = 0

-- === HILFSFUNKTIONEN ===

-- Zeigt das Main-GUI an (wird später verwendet)
local function getMainGui()
    local pg = lp and lp:FindFirstChild("PlayerGui")
    if not pg then return nil end
    return pg:FindFirstChild("Main")
end

-- Prüft, ob wir im Kampf sind ("Risk"-Anzeige)
local function isInCombatRisk()
    local main = getMainGui()
    if not main then return false end
    local inCombat = main:FindFirstChild("InCombat")
    if not inCombat then
        local hud = main:FindFirstChild("BottomHUDList")
        inCombat = hud and hud:FindFirstChild("InCombat")
    end
    if not inCombat or not inCombat.Visible then return false end
    return string.find(string.lower(tostring(inCombat.Text)), "risk") ~= nil
end

-- Prüft, ob PvP deaktiviert wurde
local function isPvpDisabled()
    local main = getMainGui()
    if not main then return false end
    local pvpFlag = main:FindFirstChild("PvpDisabled")
    if not pvpFlag then
        local hud = main:FindFirstChild("BottomHUDList")
        pvpFlag = hud and hud:FindFirstChild("PvpDisabled")
    end
    return pvpFlag and pvpFlag.Visible or false
end

local function moveToTarget(cframeTarget, instant)
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = lp.Character.HumanoidRootPart
    local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end

    if instant or not getgenv().Setting.Movement.Enable then
        hrp.CFrame = cframeTarget
        return
    end

    local speed = getgenv().Setting.Movement.Speed
    local startPos = hrp.Position
    local targetPos = cframeTarget.Position
    local distance = (targetPos - startPos).Magnitude
    if distance < 0.1 then return end

    local bodyVel = hrp:FindFirstChild("Hold")
    if not bodyVel then
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.Name = "Hold"
        bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVel.P = 10000
        bodyVel.Parent = hrp
    end
    local bodyGyro = hrp:FindFirstChild("BodyGyro")
    if not bodyGyro then
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.P = 10000
        bodyGyro.Parent = hrp
    end

    bodyVel.Velocity = (targetPos - startPos).Unit * speed
    getgenv()._moveTo = {hrp = hrp, targetPos = targetPos, speed = speed, bodyVel = bodyVel, bodyGyro = bodyGyro}
end

function to(Pos)
    moveToTarget(Pos, false)
end

-- === BUSO / KEN HAKI ===
function buso()
    if lp.Character and not lp.Character:FindFirstChild("HasBuso") then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end

function Ken()
    if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and
       game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") and
       game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
        return true
    else
        game:service("VirtualUser"):CaptureController()
        game:service("VirtualUser"):SetKeyDown("0x65")
        game:service("VirtualUser"):SetKeyUp("0x65")
        return false
    end
end

-- Tasten senden
function down(use, wait)
    pcall(function()
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            game:GetService("VirtualInputManager"):SendKeyEvent(true, use, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
            task.wait((wait or 0.1))
            game:GetService("VirtualInputManager"):SendKeyEvent(false, use, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
        end
    end)
end

-- Waffe ausrüsten
function equip(tooltip)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:wait()
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == tooltip then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and not humanoid:IsDescendantOf(item) then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
                return true
            end
        end
    end
    return false
end

function EquipWeapon(Tool)
    pcall(function()
        if game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) then
            local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool)
            if ToolHumanoid then
                ToolHumanoid.Parent = game.Players.LocalPlayer.Character
            end
        end
    end)
end

function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,1,0,1))
end

task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if isPvpDisabled() then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
            end
        end)
    end
end)

spawn(function()
    while game:GetService("RunService").Stepped:wait() do
        pcall(function()
            if lp.Character then
                for _, v in pairs(lp.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
end)

local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, index)
    if self == lp:GetMouse() and (index == "Hit" or index == "Target") and getgenv().targ and getgenv().targ.Character then
        local root = getgenv().targ.Character:FindFirstChild("HumanoidRootPart")
        if root then
            return index == "Hit" and root.CFrame or root
        end
    end
    return oldIndex(self, index)
end)

-- FPS-Boost (optional)
if getgenv().Setting.Another.FPSBoots then
    local removedecals = false
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering
