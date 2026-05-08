local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlaceID = game.PlaceId

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "PremiumHopHub"

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 280, 0, 160)
Main.Position = UDim2.new(0.5, -140, 0.5, -80)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Shadow = Instance.new("Frame")
Shadow.Parent = Main
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 0.8
Shadow.BackgroundColor3 = Color3.new(0,0,0)
Shadow.ZIndex = 0

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,35)
Title.Text = "Night Slayer Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundColor3 = Color3.fromRGB(30,30,30)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

Instance.new("UICorner", Title)

local Button = Instance.new("TextButton")
Button.Parent = Main
Button.Size = UDim2.new(0.8,0,0,45)
Button.Position = UDim2.new(0.1,0,0.45,0)
Button.Text = "Server Hop"
Button.BackgroundColor3 = Color3.fromRGB(0,170,255)
Button.TextColor3 = Color3.new(1,1,1)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14

Instance.new("UICorner", Button)

Button.MouseEnter:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0,200,255)
    }):Play()
end)

Button.MouseLeave:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0,170,255)
    }):Play()
end)

local function MakeDraggable(dragFrame, moveFrame)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    local function update(input)
        local delta = input.Position - dragStart

        local newPos = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )

        local screenSize = workspace.CurrentCamera.ViewportSize
        local x = math.clamp(newPos.X.Offset, 0, screenSize.X - moveFrame.AbsoluteSize.X)
        local y = math.clamp(newPos.Y.Offset, 0, screenSize.Y - moveFrame.AbsoluteSize.Y)

        moveFrame.Position = UDim2.new(0, x, 0, y)
    end

    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
        or input.UserInputType == Enum.UserInputType.Touch then
            
            dragging = true
            dragStart = input.Position
            startPos = moveFrame.Position

            TweenService:Create(moveFrame, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 290, 0, 170)
            }):Play()

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false

                    TweenService:Create(moveFrame, TweenInfo.new(0.1), {
                        Size = UDim2.new(0, 280, 0, 160)
                    }):Play()
                end
            end)
        end
    end)

    dragFrame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement 
        or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            update(input)
        end
    end)
end

MakeDraggable(Title, Main)

local function Notify(text)
    local Noti = Instance.new("Frame")
    Noti.Parent = ScreenGui
    Noti.Size = UDim2.new(0, 250, 0, 50)
    Noti.Position = UDim2.new(1, 300, 1, -60)
    Noti.BackgroundColor3 = Color3.fromRGB(30,30,30)

    Instance.new("UICorner", Noti)

    local Label = Instance.new("TextLabel")
    Label.Parent = Noti
    Label.Size = UDim2.new(1, -10, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.new(1,1,1)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    TweenService:Create(Noti, TweenInfo.new(0.3), {
        Position = UDim2.new(1, -260, 1, -60)
    }):Play()

    task.wait(3)

    TweenService:Create(Noti, TweenInfo.new(0.3), {
        Position = UDim2.new(1, 300, 1, -60)
    }):Play()

    task.wait(0.3)
    Noti:Destroy()
end

local hopping = false

local function ServerHop()
    if hopping then return end
    hopping = true

    Notify("Đang tìm server...")

    local servers = {}
    local req = game:HttpGet(
        "https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?sortOrder=Asc&limit=100"
    )

    local data = HttpService:JSONDecode(req)

    for _,v in pairs(data.data) do
        if v.playing < v.maxPlayers then
            table.insert(servers, v.id)
        end
    end

    if #servers > 0 then
        local server = servers[math.random(1,#servers)]
        Notify("Đang chuyển server...")
        TeleportService:TeleportToPlaceInstance(PlaceID, server, player)
    else
        Notify("Không có server phù hợp!")
    end

    task.wait(5)
    hopping = false
end

Button.MouseButton1Click:Connect(function()
    ServerHop()
end)
