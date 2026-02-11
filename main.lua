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

-- ===============================
-- Main GUI Frame
-- ===============================
local HEADER_HEIGHT = 40
local SIDEBAR_WIDTH = 150 -- Slightly wider for better text fit

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHubV2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui or PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(80, 160, 255)
MainStroke.Thickness = 1.5

-- ===============================
-- Header
-- ===============================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, HEADER_HEIGHT)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub V2"
Title.TextColor3 = Color3.fromRGB(200, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 35, 0, 25)
Close.Position = UDim2.new(1, -45, 0, 7)
Close.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.Parent = Header
Instance.new("UICorner", Close)

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0, 35, 0, 25)
Minimize.Position = UDim2.new(1, -85, 0, 7)
Minimize.BackgroundColor3 = Color3.fromRGB(70, 170, 255)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 14
Minimize.Parent = Header
Instance.new("UICorner", Minimize)

-- ===============================
-- Left Sidebar
-- ===============================
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, SIDEBAR_WIDTH, 1, -HEADER_HEIGHT)
Sidebar.Position = UDim2.new(0, 0, 0, HEADER_HEIGHT)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Sidebar.ScrollBarThickness = 2
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.Parent = Main

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingLeft = UDim.new(0, 5)
SidebarPadding.PaddingRight = UDim.new(0, 5)
SidebarPadding.PaddingTop = UDim.new(0, 5)

SidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, SidebarLayout.AbsoluteContentSize.Y + 10)
end)

-- ===============================
-- Right Content Area
-- ===============================
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -SIDEBAR_WIDTH, 1, -HEADER_HEIGHT)
Content.Position = UDim2.new(0, SIDEBAR_WIDTH, 0, HEADER_HEIGHT)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.BorderSizePixel = 0
Content.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = Content

local ContentPadding = Instance.new("UIPadding", Content)
ContentPadding.PaddingLeft = UDim.new(0, 10)
ContentPadding.PaddingRight = UDim.new(0, 10)
ContentPadding.PaddingTop = UDim.new(0, 10)

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- ===============================
-- Simple Drag Function
-- ===============================
local function Drag(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
Drag(Main)

-- ===============================
-- Framework Logic
-- ===============================
local KaLiHub = {}
local TabsContent = {}
local FirstTab = true

function KaLiHub:CreateTab(name)
    local Tab = {}
    local DropdownOpen = false
    local ChildrenButtons = {}

    -- Main Dropdown Button
    local MainBtn = Instance.new("TextButton")
    MainBtn.Size = UDim2.new(1, 0, 0, 35)
    MainBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainBtn.Font = Enum.Font.GothamBold
    MainBtn.TextSize = 13
    MainBtn.Text = name
    MainBtn.Parent = Sidebar
    Instance.new("UICorner", MainBtn)

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -25, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(200, 200, 255)
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 12
    Arrow.Parent = MainBtn

    MainBtn.MouseButton1Click:Connect(function()
        DropdownOpen = not DropdownOpen
        TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = DropdownOpen and 180 or 0}):Play()
        for _, btn in pairs(ChildrenButtons) do
            btn.Visible = DropdownOpen
        end
    end)

    function Tab:Button(btnName)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -10, 0, 30)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        Btn.Text = "  " .. btnName
        Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 12
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.Visible = false
        Btn.Parent = Sidebar
        Instance.new("UICorner", Btn)

        table.insert(ChildrenButtons, Btn)

        -- Content Frame
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 0)
        Frame.BackgroundTransparency = 1
        Frame.Visible = false
        Frame.Parent = Content

        local Layout = Instance.new("UIListLayout")
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0, 10)
        Layout.Parent = Frame

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Frame.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y)
        end)

        Btn.MouseButton1Click:Connect(function()
            for _, v in pairs(TabsContent) do v.Frame.Visible = false end
            Frame.Visible = true
        end)

        -- Default show first item
        if FirstTab then
            Frame.Visible = true
            FirstTab = false
        end

        local SubTab = {}
        function SubTab:Section(txt)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 25)
            Label.BackgroundTransparency = 1
            Label.Text = txt:upper()
            Label.TextColor3 = Color3.fromRGB(80, 160, 255)
            Label.Font = Enum.Font.GothamBold
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame
        end

        function SubTab:Button(text, callback)
            local Btn2 = Instance.new("TextButton")
            Btn2.Size = UDim2.new(1, 0, 0, 32)
            Btn2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            Btn2.Text = text
            Btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn2.Font = Enum.Font.Gotham
            Btn2.TextSize = 13
            Btn2.Parent = Frame
            Instance.new("UICorner", Btn2)
            
            local Stroke = Instance.new("UIStroke", Btn2)
            Stroke.Color = Color3.fromRGB(60,60,70)
            
            Btn2.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        TabsContent[btnName] = {Frame = Frame}
        return SubTab
    end

    return Tab
end

-- ===============================
-- Example Usage
-- ===============================
local MainTab = KaLiHub:CreateTab("Main")
local Sub1 = MainTab:Button("General")
Sub1:Section("Testing")
Sub1:Button("Print Hello", function() print("Hello World!") end)

local PlayerTab = KaLiHub:CreateTab("Movement")
local Sub2 = PlayerTab:Button("Speeds")
Sub2:Section("Modifiers")
Sub2:Button("Set Speed 50", function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 50
    end
end)

Minimize.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

return KaLiHub
