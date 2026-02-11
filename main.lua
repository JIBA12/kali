-- KaLiHub V2 - Mobile-Friendly Scrollable Tabs

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
Main.Size = UDim2.new(0, 400, 0, 300) -- wider for sidebar
Main.Position = UDim2.new(0.5, -200, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BackgroundTransparency = 0.05
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
Header.Size = UDim2.new(1,0,0,40)
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

-- Close Button
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

-- Minimize Button
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
-- Left Scrollable Tab Sidebar
-- ===============================
local TabsSidebar = Instance.new("ScrollingFrame")
TabsSidebar.Size = UDim2.new(0,100,1,-40)
TabsSidebar.Position = UDim2.new(0,0,0,40)
TabsSidebar.BackgroundColor3 = Color3.fromRGB(30,30,35)
TabsSidebar.ScrollBarThickness = 6
TabsSidebar.Parent = Main

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0,5)
TabsLayout.Parent = TabsSidebar

-- ===============================
-- Right Scrollable Content Area
-- ===============================
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1,-110,1,-40)
ContentScroll.Position = UDim2.new(0,105,0,40)
ContentScroll.BackgroundTransparency = 1
ContentScroll.ScrollBarThickness = 6
ContentScroll.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0,5)
ContentLayout.Parent = ContentScroll

-- Resize canvas automatically
ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentScroll.CanvasSize = UDim2.new(0,0,0,ContentLayout.AbsoluteContentSize.Y + 10)
end)

-- ===============================
-- Drag Function (PC + Mobile)
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
Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false

    if not FloatingButton then
        FloatingButton = Instance.new("TextButton")
        FloatingButton.Size = UDim2.new(0,40,0,40)
        FloatingButton.Position = UDim2.new(0.5,-20,0.5,-20)
        FloatingButton.BackgroundColor3 = Color3.fromRGB(70,170,255)
        FloatingButton.Text = "K"
        FloatingButton.TextColor3 = Color3.fromRGB(255,255,255)
        FloatingButton.Font = Enum.Font.GothamBold
        FloatingButton.TextSize = 18
        FloatingButton.Parent = ScreenGui
        Instance.new("UICorner", FloatingButton)

        Drag(FloatingButton)

        FloatingButton.MouseButton1Click:Connect(function()
            Main.Visible = true
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
local Tabs = {}

function KaLiHub:CreateTab(name)
    -- Tab content frame inside right scrollable area
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1,0,0,0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false
    TabFrame.Parent = ContentScroll

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0,5)
    TabLayout.Parent = TabFrame

    -- Left sidebar button
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1,0,0,40)
    TabButton.Text = name
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 14
    TabButton.TextColor3 = Color3.fromRGB(255,255,255)
    TabButton.BackgroundColor3 = Color3.fromRGB(40,40,50)
    TabButton.Parent = TabsSidebar
    Instance.new("UICorner", TabButton)

    TabButton.MouseButton1Click:Connect(function()
        for _,v in pairs(Tabs) do
            v.Frame.Visible = false
            v.Button.BackgroundColor3 = Color3.fromRGB(40,40,50)
        end
        TabFrame.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(70,160,255)
    end)

    Tabs[name] = {Frame = TabFrame, Button = TabButton}

    local Tab = {}

    -- Section
    function Tab:Section(text)
        local SectionLabel = Instance.new("TextLabel")
        SectionLabel.Size = UDim2.new(1,0,0,20)
        SectionLabel.BackgroundTransparency = 1
        SectionLabel.Text = text
        SectionLabel.TextColor3 = Color3.fromRGB(100,180,255)
        SectionLabel.Font = Enum.Font.GothamBold
        SectionLabel.TextSize = 13
        SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        SectionLabel.Parent = TabFrame

        local Divider = Instance.new("Frame")
        Divider.Size = UDim2.new(1,0,0,1)
        Divider.BackgroundColor3 = Color3.fromRGB(60,60,75)
        Divider.BorderSizePixel = 0
        Divider.Parent = TabFrame
    end

    -- Button
    function Tab:Button(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,0,0,25)
        Btn.BackgroundColor3 = Color3.fromRGB(60,60,75)
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 14
        Btn.Parent = TabFrame
        Instance.new("UICorner", Btn)

        Btn.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
    end

    -- Toggle
    function Tab:Toggle(text, default, callback)
        local state = default
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,0,0,25)
        Btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 14
        Btn.Parent = TabFrame
        Instance.new("UICorner", Btn)

        Btn.MouseButton1Click:Connect(function()
            state = not state
            Btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
            pcall(function() callback(state) end)
        end)
    end

    return Tab
end

-- ===============================
-- Example Tabs
-- ===============================
local MainTab = KaLiHub:CreateTab("Main")
MainTab:Section("Features")
MainTab:Button("Test Button", function() print("Clicked!") end)
MainTab:Toggle("Auto Farm", false, function(v) print("Toggle:",v) end)

local PlayerTab = KaLiHub:CreateTab("Player")
PlayerTab:Section("Player Options")
PlayerTab:Button("Speed Boost", function()
    local char = Player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.WalkSpeed = 50
    end
end)

return KaLiHub
