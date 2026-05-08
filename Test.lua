
getgenv().team = "Pirates" -- Marines

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
	
-- >>> TẢI Xury UI <
-- Tải UI trước khi khởi tạo auto bounty	
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ImageWithBlur"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Tạo hiệu ứng blur full màn hình
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 24
blurEffect.Parent = game:GetService("Lighting")

-- Frame chứa toàn bộ UI
local containerFrame = Instance.new("Frame")
containerFrame.Size = UDim2.new(1, 0, 1, 0)
containerFrame.Position = UDim2.new(0, 0, 1, 0) -- bắt đầu từ dưới màn hình
containerFrame.BackgroundTransparency = 1
containerFrame.Parent = screenGui

-- Transparent background frame
local transparentFrame = Instance.new("Frame")
transparentFrame.Size = UDim2.new(1, 0, 1, 0)
transparentFrame.BackgroundTransparency = 1
transparentFrame.Parent = containerFrame

-- Hình ảnh ở giữa màn hình
local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 170, 0, 170)
imageLabel.Position = UDim2.new(0.5, -100, 0.5, -120)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://129934580298278"
imageLabel.Parent = containerFrame

-- Label hiển thị thời gian
local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0, 200, 0, 20)
timeLabel.Position = UDim2.new(0.5, -100, 0.5, 155)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
timeLabel.TextScaled = true
timeLabel.Font = Enum.Font.GothamBold
timeLabel.Text = "00 Hour (h) 00 Minute (m) 00 Second (s)"
timeLabel.Parent = containerFrame

-- Lixuryx Hub Auto Bounty label (above image)
local lixuryxLabel = Instance.new("TextLabel")
lixuryxLabel.Size = UDim2.new(0, 300, 0, 40)
lixuryxLabel.Position = UDim2.new(0.5, -150, 0.5, -200)
lixuryxLabel.BackgroundTransparency = 1
lixuryxLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
lixuryxLabel.TextScaled = true
lixuryxLabel.Font = Enum.Font.GothamBold
lixuryxLabel.Text = "Chú Roblox | Auto Bounty"
lixuryxLabel.Parent = containerFrame

-- Label nhỏ nằm trên: (free)
local premiumLabel = Instance.new("TextLabel")
premiumLabel.Size = UDim2.new(0, 90, 0, 15)
premiumLabel.Position = UDim2.new(0.5, 125, 0.5, -200) -- lệch lên và sang phải
premiumLabel.BackgroundTransparency = 1
premiumLabel.TextColor3 = Color3.fromRGB(230, 230, 255) -- màu vàng nhẹ
premiumLabel.TextScaled = true
premiumLabel.Font = Enum.Font.GothamBold
premiumLabel.Text = "[Freemium]"
premiumLabel.Parent = containerFrame

-- Discord link label (below Lixuryx)
local discordLabel = Instance.new("TextLabel")
discordLabel.Size = UDim2.new(0, 120, 0, 10)
discordLabel.Position = UDim2.new(0.5, -63, 0.5, 150)
discordLabel.BackgroundTransparency = 1
discordLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
discordLabel.TextScaled = true
discordLabel.Font = Enum.Font.GothamBold
discordLabel.Text = "https://discord.gg/3EwNuXTNCU"
discordLabel.Parent = containerFrame

-- Hiển thị tên người chơi ở góc trên bên phải
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

-- Bounty label
local bountyLabel = Instance.new("TextLabel")
bountyLabel.Size = UDim2.new(0, 110, 0, 10)
bountyLabel.Position = UDim2.new(0.5, -45, 0.5, -165)
bountyLabel.BackgroundTransparency = 1
bountyLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
bountyLabel.TextScaled = true
bountyLabel.Font = Enum.Font.GothamBold
bountyLabel.TextXAlignment = Enum.TextXAlignment.Left
bountyLabel.Text = "Current Bounty: "..game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value
bountyLabel.Parent = containerFrame

--[[ Skip Player
local skipButton = Instance.new("TextButton")
skipButton.Size = UDim2.new(0, 80, 0, 30)
skipButton.Position = UDim2.new(0.5, 275, 0.5, -165)
skipButton.BackgroundTransparency = 1
skipButton.Text = "Skip Player"
skipButton.TextColor3 = Color3.fromRGB(230, 230, 255)
skipButton.TextScaled = true
skipButton.Font = Enum.Font.GothamBold
skipButton.Parent = containerFrame

-- Tạo viền
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(230, 230, 255)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = skipButton

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = skipButton

-- Hiệu ứng khi hover chuột
skipButton.MouseEnter:Connect(function()
	skipButton.BackgroundTransparency = 0.85
end)

skipButton.MouseLeave:Connect(function()
	skipButton.BackgroundTransparency = 1
end)

-- Khi click vào nút Skip
skipButton.MouseButton1Click:Connect(function()
	SkipPlayer()
	end) ]]--
	
--[[ Total label
local bountyLabel = Instance.new("TextLabel")
bountyLabel.Size = UDim2.new(0, 110, 0, 10)
bountyLabel.Position = UDim2.new(0, 10, 1, -30)
bountyLabel.BackgroundTransparency = 1
bountyLabel.TextColor3 = Color3.new(230/255, 230/255, 255/255)
bountyLabel.TextScaled = true
bountyLabel.Font = Enum.Font.GothamBold
bountyLabel.TextXAlignment = Enum.TextXAlignment.Left
bountyLabel.Text = "Total Earned:"
bountyLabel.Parent = containerFrame ]]--

-- Tween container từ dưới lên
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local goal = { Position = UDim2.new(0, 0, 0, 0) }
local tween = TweenService:Create(containerFrame, tweenInfo, goal)
tween:Play()

-- Bắt đầu đếm thời gian sau tween
local startTime = tick()
tween.Completed:Connect(function()
    -- Bắt đầu cập nhật thời gian sau khi tween hoàn tất
    task.spawn(function()
        while screenGui.Parent do
            local elapsed = math.floor(tick() - startTime)
            local hours = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local seconds = elapsed % 60
            timeLabel.Text = string.format("%02d Hour (h) %02d Minute (m) %02d Second (s)", hours, minutes, seconds)
            task.wait(1)
        end
    end)
				end)
				
-- Khởi tạo cài đặt cơ bản nếu chưa tồn tại
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
        ["MaxPlayersInServer"] = 8
    }
end

-- Khởi tạo biến toàn cục
getgenv().weapon = nil
getgenv().targ = nil 
getgenv().lasttarrget = nil
getgenv().checked = {}
getgenv().pl = game.Players:GetPlayers()
getgenv().killed = nil
-- Định nghĩa thế giới và cấu hình đảo
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
-- Cấu hình đảo dựa trên thế giới
local distbyp, island
if World3 then 
    distbyp = 5000
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
    distbyp = 3500
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
    distbyp = 1500
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

-- Định nghĩa biến cục bộ
local p = game.Players
local lp = p.LocalPlayer
local rs = game:GetService("RunService")
local hb = rs.Heartbeat
local rends = rs.RenderStepped
local webhook = {} 

-- === CÁC HÀM TIỆN ÍCH ===
-- Hàm vượt qua chướng ngại
function bypass(Pos)   
    if not lp.Character:FindFirstChild("Head") or not lp.Character:FindFirstChild("HumanoidRootPart") or not lp.Character:FindFirstChild("Humanoid") then
        return
    end
    
    local dist = math.huge
    local is = nil
    
    for i, v in pairs(island) do
        if (Pos.Position-v.Position).magnitude < dist then
            is = v 
            dist = (Pos.Position-v.Position).magnitude 
        end
    end 
    
    if is == nil then return end
    
    if lp:DistanceFromCharacter(Pos.Position) > distbyp then 
        if (lp.Character.Head.Position-Pos.Position).magnitude > (is.Position-Pos.Position).magnitude then
            if tween then
                pcall(function() tween:Destroy() end)
            end
            
            if (is.X == 61163.8515625 and is.Y == 11.6796875 and is.Z == 1819.7841796875) or 
               is == CFrame.new(-12471.169921875 + 50, 374.94024658203, -7551.677734375) or 
               is == CFrame.new(-5085.23681640625 + 50, 316.5072021484375, -3156.202880859375) or 
               is == CFrame.new(5749.7861328125 + 50, 611.9736938476562, -276.2497863769531) then
                
                if tween then
                   pcall(function() tween:Cancel() end)
                end
                
                repeat task.wait()
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                        lp.Character.HumanoidRootPart.CFrame = is  
                    else
                        break
                    end
                until lp.Character and lp.Character.PrimaryPart and lp.Character.PrimaryPart.CFrame == is   
                
                task.wait(0.1)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            else
                if not stopbypass then
                    if tween then
                       pcall(function() tween:Cancel() end)
                    end
                    
                    repeat task.wait()
                        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                            lp.Character.HumanoidRootPart.CFrame = is  
                        else
                            break
                        end
                    until lp.Character and lp.Character.PrimaryPart and lp.Character.PrimaryPart.CFrame == is  
                    
                    pcall(function()
                        game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
                        lp.Character:SetPrimaryPartCFrame(is)
                        wait(0.1)
                        if lp.Character and lp.Character:FindFirstChild("Head") then
                            lp.Character.Head:Destroy()
                        end
                        wait(0.5)
                        
                        repeat task.wait()
                            if lp.Character and lp.Character:FindFirstChild("PrimaryPart") then
                                lp.Character.PrimaryPart.CFrame = is  
                            else
                                break
                            end
                        until lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Health > 0
                        
                        task.wait(0.5)
                    end)
                end 
            end
        end
    end
end

function to(Pos)
    pcall(function()
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Health > 0 then
            local Distance = (Pos.Position - lp.Character.HumanoidRootPart.Position).Magnitude

            if not lp.Character.PrimaryPart:FindFirstChild("Hold") then
                local Hold = Instance.new("BodyVelocity", lp.Character.PrimaryPart)
                Hold.Name = "Hold"
                Hold.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                Hold.Velocity = Vector3.new(0,0,0)
            end

            if lp.Character.Humanoid.Sit then
                lp.Character.Humanoid.Sit = false
            end

            -- TP thẳng thay vì tween
            lp.Character.HumanoidRootPart.CFrame = Pos

            if lp.PlayerGui:FindFirstChild("Main") and 
               lp.PlayerGui.Main:FindFirstChild("InCombat") and
               lp.PlayerGui.Main.InCombat.Visible then

                if string.find(string.lower(lp.PlayerGui.Main.InCombat.Text),"risk") then
                    local dist = math.huge
                    local is = nil

                    for i,v in pairs(island) do
                        local d = (Pos.Position - v.Position).Magnitude
                        if d < dist then
                            dist = d
                            is = v
                        end
                    end

                    if is == nil then return end

                    if lp:DistanceFromCharacter(Pos.Position) > distbyp then
                        if (lp.Character.Head.Position-Pos.Position).Magnitude > (is.Position-Pos.Position).Magnitude then

                            if (is.X == 61163.8515625 and is.Y == 11.6796875 and is.Z == 1819.7841796875) or 
                               is == CFrame.new(-12471.169921875 + 50, 374.94024658203, -7551.677734375) or 
                               is == CFrame.new(-5085.23681640625 + 50, 316.5072021484375, -3156.202880859375) or 
                               is == CFrame.new(5749.7861328125 + 50, 611.9736938476562, -276.2497863769531) then

                                repeat task.wait()
                                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                                        lp.Char
