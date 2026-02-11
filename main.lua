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

local parentGui = CoreGui
pcall(function() if gethui then parentGui = gethui() end end)

-- ===============================
-- Main Setup
-- ===============================
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
-- Drag Logic (Universal)
-- ===============================
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

MakeDraggable(Main)

-- ===============================
-- Header & Components
-- ===============================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
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
Close.Parent = Header
Instance.new("UICorner", Close)

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0, 35, 0, 25)
Minimize.Position = UDim2.new(1, -85, 0, 7)
Minimize.BackgroundColor3 = Color3.fromRGB(70, 170, 255)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.Font = Enum.Font.GothamBold
Minimize.Parent = Header
Instance.new("UICorner", Minimize)

-- ===============================
-- Sidebar & Content
-- ===============================
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 150, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Sidebar.ScrollBarThickness = 2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.Parent = Sidebar

SidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, SidebarLayout.AbsoluteContentSize.Y + 10)
end)

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -150, 1, -40)
Content.Position = UDim2.new(0, 150, 0, 40)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.BorderSizePixel = 0
Content.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = Content

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- ===============================
-- Floating Button Logic
-- ===============================
local FloatingBtn
local lastPos = UDim2.new(0, 50, 0, 50)

local function CreateFloatingButton()
    FloatingBtn = Instance.new("TextButton")
    FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
    FloatingBtn.Position = lastPos
    FloatingBtn.BackgroundColor3 = Color3.fromRGB(70, 170, 255)
    FloatingBtn.Text = "K"
    FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FloatingBtn.Font = Enum.Font.GothamBold
    FloatingBtn.TextSize = 20
    FloatingBtn.Parent = ScreenGui
    Instance.new("UICorner", FloatingBtn)
    Instance.new("UIStroke", FloatingBtn).Thickness = 2
    
    MakeDraggable(FloatingBtn)
    
    FloatingBtn.MouseButton1Click:Connect(function()
        lastPos = FloatingBtn.Position
        Main.Visible = true
        FloatingBtn:Destroy()
        FloatingBtn = nil
    end)
end

Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
    CreateFloatingButton()
end)

Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ===============================
-- Framework Functions
-- ===============================
local KaLiHub = {}
function KaLiHub:CreateTab(name)
    local Tab = {}
    local DropdownOpen = false
    local ChildrenButtons = {}

    local MainBtn = Instance.new("TextButton")
    MainBtn.Size = UDim2.new(1, -10, 0, 35)
    MainBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    MainBtn.Text = name
    MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainBtn.Font = Enum.Font.GothamBold
    MainBtn.Parent = Sidebar
    Instance.new("UICorner", MainBtn)

    MainBtn.MouseButton1Click:Connect(function()
        DropdownOpen = not DropdownOpen
        for _, btn in pairs(ChildrenButtons) do btn.Visible = DropdownOpen end
    end)

    function Tab:Button(btnName)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -20, 0, 30)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        Btn.Text = btnName
        Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        Btn.Visible = false
        Btn.Parent = Sidebar
        Instance.new("UICorner", Btn)
        table.insert(ChildrenButtons, Btn)

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -20, 0, 0)
        Frame.BackgroundTransparency = 1
        Frame.Visible = false
        Frame.Parent = Content
        local L = Instance.new("UIListLayout", Frame)
        L.Padding = UDim.new(0, 5)
        
        L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Frame.Size = UDim2.new(1, 0, 0, L.AbsoluteContentSize.Y)
        end)

        Btn.MouseButton1Click:Connect(function()
            for _, v in pairs(Content:GetChildren()) do if v:IsA("Frame") then v.Visible = false end end
            Frame.Visible = true
        end)

        local Sub = {}
        function Sub:Button(text, callback)
            local b = Instance.new("TextButton", Frame)
            b.Size = UDim2.new(1, 0, 0, 30)
            b.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            b.Text = text
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() pcall(callback) end)
        end
        return Sub
    end
    return Tab
end

-- ===============================
-- Usage Example
-- ===============================
local MainTab = KaLiHub:CreateTab("Main")
local Sub1 = MainTab:Button("Example Section")
Sub1:Button("Print Hello", function() print("Hello!") end)

return KaLiHub
