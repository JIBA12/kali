--// KaLiHub V2 - Modern UI (Mobile + PC)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old GUI
pcall(function()
    if CoreGui:FindFirstChild("KaLiHubV2") then
        CoreGui.KaLiHubV2:Destroy()
    end
end)

-- Parent safely
local parentGui = CoreGui
pcall(function()
    if gethui then
        parentGui = gethui()
    end
end)

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHubV2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui or PlayerGui

-- ===============================
-- Main Window
-- ===============================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,400,0,450)
Main.Position = UDim2.new(0.5,-200,0.5,-225)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BackgroundTransparency = 0.05
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0,12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(80,160,255)
MainStroke.Thickness = 1

local MainGradient = Instance.new("UIGradient", Main)
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20,20,25))
}

-- ===============================
-- Header
-- ===============================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,45)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-90,1,0)
Title.Position = UDim2.new(0,15,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub V2"
Title.TextColor3 = Color3.fromRGB(200,200,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Buttons
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,40,0,35)
Close.Position = UDim2.new(1,-45,0,5)
Close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.Parent = Header
Instance.new("UICorner", Close)

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,40,0,35)
Minimize.Position = UDim2.new(1,-90,0,5)
Minimize.BackgroundColor3 = Color3.fromRGB(70,170,255)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255,255,255)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.Parent = Header
Instance.new("UICorner", Minimize)

-- ===============================
-- Sidebar
-- ===============================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,120,1,-45)
Sidebar.Position = UDim2.new(0,0,0,45)
Sidebar.BackgroundTransparency = 0.05
Sidebar.BackgroundColor3 = Color3.fromRGB(30,30,40)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0,4)

-- ===============================
-- Content Area
-- ===============================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-120,1,-45)
Content.Position = UDim2.new(0,120,0,45)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- ===============================
-- Floating Icon
-- ===============================
local Float = Instance.new("TextButton")
Float.Size = UDim2.new(0,60,0,60)
Float.Position = UDim2.new(0,20,0.5,-30)
Float.BackgroundColor3 = Color3.fromRGB(70,170,255)
Float.Text = "K"
Float.TextColor3 = Color3.fromRGB(255,255,255)
Float.Visible = false
Float.Parent = ScreenGui
Instance.new("UICorner", Float)

-- ===============================
-- Drag System
-- ===============================
local function Drag(frame)
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

Drag(Main)
Drag(Float)

-- ===============================
-- Minimize / Close
-- ===============================
Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
    Float.Visible = true
end)

Float.MouseButton1Click:Connect(function()
    Main.Visible = true
    Float.Visible = false
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ===============================
-- KaLiHub V2 Framework
-- ===============================
local KaLiHub = {}
local firstTab = true

function KaLiHub:CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1,0,0,40)
    TabButton.Text = name
    TabButton.BackgroundColor3 = Color3.fromRGB(45,45,55)
    TabButton.TextColor3 = Color3.fromRGB(255,255,255)
    TabButton.Parent = Sidebar
    Instance.new("UICorner", TabButton)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1,0,1,0)
    Page.CanvasSize = UDim2.new()
    Page.ScrollBarThickness = 5
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0,6)

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
    end)

    if firstTab then
        firstTab = false
        Page.Visible = true
    end

    TabButton.MouseButton1Click:Connect(function()
        for _,v in pairs(Content:GetChildren()) do
            if v:IsA("ScrollingFrame") then
                v.Visible = false
            end
        end
        Page.Visible = true
    end)

    local Tab = {}

    function Tab:Section(text)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1,-10,0,25)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(100,180,255)
        Label.Font = Enum.Font.GothamBold
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Page
    end

    function Tab:Button(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,-10,0,35)
        Btn.BackgroundColor3 = Color3.fromRGB(60,60,75)
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Parent = Page
        Instance.new("UICorner", Btn)

        Btn.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
    end

    function Tab:Toggle(text, default, callback)
        local state = default
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,-10,0,35)
        Btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Parent = Page
        Instance.new("UICorner", Btn)

        Btn.MouseButton1Click:Connect(function()
            state = not state
            Btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
            pcall(function()
                callback(state)
            end)
        end)
    end

    return Tab
end

-- ===============================
-- Example Usage
-- ===============================
local MainTab = KaLiHub:CreateTab("Main")
MainTab:Section("Features")
MainTab:Button("Test Button", function()
    print("Clicked!")
end)
MainTab:Toggle("Auto Farm", false, function(v)
    print("Toggle:",v)
end)

local PlayerTab = KaLiHub:CreateTab("Player")
PlayerTab:Section("Player Options")
PlayerTab:Button("Speed Boost", function()
    local char = Player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.WalkSpeed = 50
    end
end)

return KaLiHub
