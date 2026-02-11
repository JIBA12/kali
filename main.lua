-- KaLiHub V2 - Fixed Sidebar Dropdown Layout

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
local SIDEBAR_WIDTH = 140

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHubV2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui or PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,480,0,320)
Main.Position = UDim2.new(0.5,-240,0.5,-160)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(80,160,255)
MainStroke.Thickness = 1

-- ===============================
-- Header
-- ===============================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,HEADER_HEIGHT)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-120,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub V2"
Title.TextColor3 = Color3.fromRGB(200,200,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,35,0,30)
Close.Position = UDim2.new(1,-40,0,5)
Close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.Parent = Header
Instance.new("UICorner", Close)

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,35,0,30)
Minimize.Position = UDim2.new(1,-80,0,5)
Minimize.BackgroundColor3 = Color3.fromRGB(70,170,255)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255,255,255)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 16
Minimize.Parent = Header
Instance.new("UICorner", Minimize)

-- ===============================
-- Left Sidebar (Fixed, Scrollable)
-- ===============================
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0,SIDEBAR_WIDTH,1,-HEADER_HEIGHT)
Sidebar.Position = UDim2.new(0,0,0,HEADER_HEIGHT)
Sidebar.BackgroundColor3 = Color3.fromRGB(30,30,35)
Sidebar.ScrollBarThickness = 6
Sidebar.Parent = Main

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0,2)
SidebarLayout.Parent = Sidebar

-- ===============================
-- Right Content Area
-- ===============================
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1,-SIDEBAR_WIDTH,1,-HEADER_HEIGHT)
Content.Position = UDim2.new(0,SIDEBAR_WIDTH,0,HEADER_HEIGHT)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 6
Content.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0,5)
ContentLayout.Parent = Content

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.new(0,0,0,ContentLayout.AbsoluteContentSize.Y + 10)
end)

-- ===============================
-- Drag Function
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

-- ===============================
-- Minimize / Close
-- ===============================
local FloatingButton
local lastPos = UDim2.new(0.5,-20,0.5,-20)

Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false

    if not FloatingButton then
        FloatingButton = Instance.new("TextButton")
        FloatingButton.Size = UDim2.new(0,40,0,40)
        FloatingButton.Position = lastPos
        FloatingButton.BackgroundColor3 = Color3.fromRGB(70,170,255)
        FloatingButton.Text = "K"
        FloatingButton.TextColor3 = Color3.fromRGB(255,255,255)
        FloatingButton.Font = Enum.Font.GothamBold
        FloatingButton.TextSize = 18
        FloatingButton.Parent = ScreenGui
        Instance.new("UICorner", FloatingButton)

        local dragging = false
        local dragStart, startPos

        FloatingButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = FloatingButton.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        lastPos = FloatingButton.Position
                    end
                end)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                FloatingButton.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)

        FloatingButton.MouseButton1Click:Connect(function()
            Main.Visible = true
            lastPos = FloatingButton.Position
            FloatingButton:Destroy()
            FloatingButton = nil
        end)
    end
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ===============================
-- KaLiHub Framework
-- ===============================
local KaLiHub = {}
local TabsContent = {}

function KaLiHub:CreateTab(name)
    local Tab = {}

    -- Main Button
    local MainBtn = Instance.new("TextButton")
    MainBtn.Size = UDim2.new(1,0,0,35)
    MainBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    MainBtn.TextColor3 = Color3.fromRGB(255,255,255)
    MainBtn.Font = Enum.Font.GothamBold
    MainBtn.TextSize = 14
    MainBtn.Text = name.." ▼"
    MainBtn.Parent = Sidebar
    Instance.new("UICorner", MainBtn)

    -- Arrow
    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0,15,0,15)
    Arrow.Position = UDim2.new(1,-20,0,10)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(200,200,255)
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 12
    Arrow.Parent = MainBtn

    local DropdownOpen = false
    local ChildrenButtons = {}

    MainBtn.MouseButton1Click:Connect(function()
        DropdownOpen = not DropdownOpen
        TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = DropdownOpen and 180 or 0}):Play()
        for i,btn in pairs(ChildrenButtons) do
            btn.Visible = DropdownOpen
        end
    end)

    function Tab:Button(btnName)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,-20,0,30)
        Btn.Position = UDim2.new(0,10,0,0)
        Btn.BackgroundColor3 = Color3.fromRGB(60,60,75)
        Btn.Text = btnName
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 13
        Btn.Visible = false
        Btn.Parent = Sidebar
        Instance.new("UICorner", Btn)

        table.insert(ChildrenButtons, Btn)

        -- Content frame
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1,-10,0,0)
        Frame.Position = UDim2.new(0,5,0,0)
        Frame.BackgroundTransparency = 1
        Frame.Visible = false
        Frame.Parent = Content

        local Layout = Instance.new("UIListLayout")
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0,5)
        Layout.Parent = Frame

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Frame.Size = UDim2.new(1,-10,0,Layout.AbsoluteContentSize.Y + 10)
        end)

        Btn.MouseButton1Click:Connect(function()
            for _,v in pairs(TabsContent) do
                v.Frame.Visible = false
            end
            Frame.Visible = true
        end)

        local SubTab = {}
        function SubTab:Section(txt)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1,0,0,20)
            Label.BackgroundTransparency = 1
            Label.Text = txt
            Label.TextColor3 = Color3.fromRGB(100,180,255)
            Label.Font = Enum.Font.GothamBold
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame
        end

        function SubTab:Button(text, callback)
            local Btn2 = Instance.new("TextButton")
            Btn2.Size = UDim2.new(1,0,0,25)
            Btn2.BackgroundColor3 = Color3.fromRGB(60,60,75)
            Btn2.Text = text
            Btn2.TextColor3 = Color3.fromRGB(255,255,255)
            Btn2.Font = Enum.Font.GothamBold
            Btn2.TextSize = 14
            Btn2.Parent = Frame
            Instance.new("UICorner", Btn2)

            Btn2.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
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
local Sub1 = MainTab:Button("Features")
Sub1:Button("Test Button", function() print("Clicked!") end)

local PlayerTab = KaLiHub:CreateTab("Player")
local Sub2 = PlayerTab:Button("Player Options")
Sub2:Button("Speed Boost", function()
    local char = Player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.WalkSpeed = 50
    end
end)

return KaLiHub
