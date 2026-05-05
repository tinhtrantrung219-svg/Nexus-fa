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

local lixuryxLabel = Instance.new("TextLabel")
lixuryxLabel.Size = UDim2.new(0, 300, 0, 40)
lixuryxLabel.Position = UDim2.new(0.5, -150, 0.5, -170)
lixuryxLabel.BackgroundTransparency = 1
lixuryxLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
lixuryxLabel.TextScaled = true
lixuryxLabel.Font = Enum.Font.GothamBold
lixuryxLabel.Text = "Drex Hub | Auto Bounty"
lixuryxLabel.Parent = containerFrame

local discordLabel = Instance.new("TextLabel")
discordLabel.Size = UDim2.new(0, 120, 0, 10)
discordLabel.Position = UDim2.new(0.5, -63, 0.5, 150)
discordLabel.BackgroundTransparency = 1
discordLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
discordLabel.TextScaled = true
discordLabel.Font = Enum.Font.GothamBold
discordLabel.Text = "https://discord.gg/HGM2exC2"
discordLabel.Parent = containerFrame

local bountyLabel = Instance.new("TextLabel")
bountyLabel.Size = UDim2.new(0, 240, 0, 18)
bountyLabel.Position = UDim2.new(0.5, -120, 0.5, -125)
bountyLabel.BackgroundTransparency = 1
bountyLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
bountyLabel.TextScaled = true
bountyLabel.Font = Enum.Font.GothamBold
bountyLabel.Text = "Bounty: 0"
bountyLabel.Parent = containerFrame

local killsLabel = Instance.new("TextLabel")
killsLabel.Size = UDim2.new(0, 240, 0, 18)
killsLabel.Position = UDim2.new(0.5, -120, 0.5, -102)
killsLabel.BackgroundTransparency = 1
killsLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
killsLabel.TextScaled = true
killsLabel.Font = Enum.Font.GothamBold
killsLabel.Text = "Kills: 0"
killsLabel.Parent = containerFrame

local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local goal = { Position = UDim2.new(0, 0, 0, 0) }
local tween = TweenService:Create(containerFrame, tweenInfo, goal)
tween:Play()

local startTime = tick()
getgenv().sessionKills = getgenv().sessionKills or 0

-- Mặc định cài đặt
if not getgenv().Setting then
    getgenv().Setting = {
        ["YOU"] = {["Team"] = getgenv().team or "Pirates"},
        ["Movement"] = {["Enable"] = true, ["Speed"] = 350}, -- TĂNG TỐC ĐỘ LÊN 350
        ["Another"] = {["LoopDelay"] = 0.12}
    }
end

-- --- HÀM DI CHUYỂN ĐÃ THAY ĐỔI (FAST & SMOOTH) ---
local function moveToTarget(cframeTarget, instant)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = player.Character.HumanoidRootPart
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end

    if instant or not getgenv().Setting.Movement.Enable then
        hrp.CFrame = cframeTarget
        return
    end

    local speed = getgenv().Setting.Movement.Speed or 350
    local targetPos = cframeTarget.Position
    local distance = (targetPos - hrp.Position).Magnitude

    if distance < 1 then 
        hrp.Velocity = Vector3.new(0,0,0)
        return 
    end

    local bodyVel = hrp:FindFirstChild("Hold") or Instance.new("BodyVelocity")
    bodyVel.Name = "Hold"
    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVel.Velocity = (targetPos - hrp.Position).Unit * speed
    bodyVel.Parent = hrp
    
    local bodyGyro = hrp:FindFirstChild("BodyGyro") or Instance.new("BodyGyro")
    bodyGyro.Name = "BodyGyro"
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 20000 
    bodyGyro.CFrame = cframeTarget
    bodyGyro.Parent = hrp
end

function to(Pos)
    moveToTarget(Pos, false)
end

-- Các hàm hỗ trợ khác giữ nguyên để script không lỗi
function buso()
    if player.Character and not player.Character:FindFirstChild("HasBuso") then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end

function EquipWeapon(Tool)
    pcall(function()
        if player.Backpack:FindFirstChild(Tool) then
            player.Backpack:FindFirstChild(Tool).Parent = player.Character
        end
    end)
end

-- Vòng lặp cập nhật UI
task.spawn(function()
    while screenGui.Parent do
        local elapsed = math.floor(tick() - startTime)
        timeLabel.Text = string.format("%02d Hour %02d Minute %02d Second", math.floor(elapsed/3600), math.floor((elapsed%3600)/60), elapsed%60)
        pcall(function()
            local b = player.leaderstats["Bounty/Honor"].Value
            bountyLabel.Text = "Bounty: " .. tostring(b)
            killsLabel.Text = "Kills: " .. tostring(getgenv().sessionKills)
        end)
        task.wait(1)
    end
end)

-- Anti-Collide (Đi xuyên vật cản khi bay)
game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        if player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

print("Drex Hub - Base Loaded with Fast Movement!")
