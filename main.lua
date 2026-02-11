-- KaLiHub V2 Minimal GUI (Smaller, Draggable + Floating Icon + Header Line)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old GUI
pcall(function()
    if CoreGui:FindFirstChild("KaLiHubV2") then
        CoreGui.KaLiHubV2:Destroy()
    end
end)

local parentGui = CoreGui or PlayerGui
local HEADER_HEIGHT = 35

-- ===============================
-- ScreenGui + Main Frame
-- ===============================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHubV2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 350, 0, 220)
Main.Position = UDim2.new(0.5, -175, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(80,160,255)
MainStroke.Thickness = 1

-- ===============================
-- Header + Title + Buttons
-- ===============================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,HEADER_HEIGHT)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-70,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub V2"
Title.TextColor3 = Color3.fromRGB(200,200,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,30,0,25)
Close.Position = UDim2.new(1,-35,0,5)
Close.BackgroundColor3 = Color3.fromRGB(0,0,0)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.Parent = Header
Instance.new("UICorner", Close)

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,30,0,25)
Minimize.Position = UDim2.new(1,-70,0,5)
Minimize.BackgroundColor3 = Color3.fromRGB(0,0,0)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255,255,255)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 14
Minimize.Parent = Header
Instance.new("UICorner", Minimize)

-- ===============================
-- Header Line
-- ===============================
local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1,0,0,1)
HeaderLine.Position = UDim2.new(0,0,0,HEADER_HEIGHT-1)
HeaderLine.BackgroundColor3 = Color3.fromRGB(80,160,255)
HeaderLine.BorderSizePixel = 0
HeaderLine.Parent = Main

-- ===============================
-- Drag Function (Reusable)
-- ===============================
local function makeDraggable(frame)
    local dragging = false
    local dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(Main)

-- ===============================
-- Minimize / Close
-- ===============================
local FloatingButton
local lastPos = UDim2.new(0.5,-20,0.5,-20)

Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
    if FloatingButton then return end

    FloatingButton = Instance.new("TextButton")
    FloatingButton.Size = UDim2.new(0,35,0,35)
    FloatingButton.Position = lastPos
    FloatingButton.BackgroundColor3 = Color3.fromRGB(70,170,255)
    FloatingButton.Text = "K"
    FloatingButton.TextColor3 = Color3.fromRGB(255,255,255)
    FloatingButton.Font = Enum.Font.GothamBold
    FloatingButton.TextSize = 16
    FloatingButton.Parent = ScreenGui
    Instance.new("UICorner", FloatingButton)

    makeDraggable(FloatingButton)

    FloatingButton.MouseButton1Click:Connect(function()
        Main.Visible = true
        lastPos = FloatingButton.Position
        FloatingButton:Destroy()
        FloatingButton = nil
    end)
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
