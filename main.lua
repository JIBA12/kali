-- KaLiHub V2 - Mobile-Friendly Dropdown Sidebar Tabs

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
local HEADER_HEIGHT = 40
local SIDEBAR_WIDTH = 120

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
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
-- Left Sidebar (Dropdown Tabs)
-- ===============================
local TabsSidebar = Instance.new("ScrollingFrame")
TabsSidebar.Size = UDim2.new(0,SIDEBAR_WIDTH,1,-HEADER_HEIGHT)
TabsSidebar.Position = UDim2.new(0,0,0,HEADER_HEIGHT)
TabsSidebar.BackgroundColor3 = Color3.fromRGB(30,30,35)
TabsSidebar.ScrollBarThickness = 6
TabsSidebar.Parent = Main

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0,2)
TabsLayout.Parent = TabsSidebar

-- ===============================
-- Right Scrollable Content Area
-- ===============================
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1,-SIDEBAR_WIDTH,1,-HEADER_HEIGHT)
ContentScroll.Position = UDim2.new(0,SIDEBAR_WIDTH,0,HEADER_HEIGHT)
ContentScroll.BackgroundTransparency = 1
ContentScroll.ScrollBarThickness = 6
ContentScroll.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0,5)
ContentLayout.Parent = ContentScroll

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentScroll.CanvasSize = UDim2.new(0,0,0,ContentLayout.AbsoluteContentSize.Y + 10)
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
-- Minimize / Close (Floating Button Memory)
-- ===============================
local FloatingButton
local lastFloatingPosition = UDim2.new(0.5,-20,0.5,-20)

Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false

    if not FloatingButton then
        FloatingButton = Instance.new("TextButton")
        FloatingButton.Size = UDim2.new(0,40,0,40)
        FloatingButton.Position = lastFloatingPosition
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
                        lastFloatingPosition = FloatingButton.Position
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
            lastFloatingPosition = FloatingButton.Position
            FloatingButton:Destroy()
            FloatingButton = nil
        end)
    end
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ===============================
-- KaLiHub Framework with Dropdown Sidebar Tabs
-- ===============================
local KaLiHub = {}
local Tabs = {}

function KaLiHub:CreateTab(mainName)
    local mainTab = {}

    -- Main Button
    local MainButton = Instance.new("TextButton")
    MainButton.Size = UDim2.new(1,0,0,35)
    MainButton.Text = mainName.." ▼"
    MainButton.Font = Enum.Font.GothamBold
    MainButton.TextSize = 14
    MainButton.TextColor3 = Color3.fromRGB(255,255,255)
    MainButton.BackgroundColor3 = Color3.fromRGB(40,40,50)
    MainButton.Parent = TabsSidebar
    Instance.new("UICorner", MainButton)

    local DropdownOpen = false
    local DropdownButtons = {}

    -- Toggle dropdown visibility
    MainButton.MouseButton1Click:Connect(function()
        DropdownOpen = not DropdownOpen
        for _,btn in pairs(DropdownButtons) do
            btn.Visible = DropdownOpen
        end
    end)

    -- Function to create sub-buttons under main dropdown
    function mainTab:Button(name)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,-10,0,30)
        Btn.Position = UDim2.new(0,10,0,0)
        Btn.BackgroundColor3 = Color3.fromRGB(60,60,75)
        Btn.Text = name
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 13
        Btn.Visible = false
        Btn.Parent = TabsSidebar
        Instance.new("UICorner", Btn)

        table.insert(DropdownButtons, Btn)

        -- Create content frame for this button
        local ContentFrame = Instance.new("Frame")
        ContentFrame.Size = UDim2.new(1,-10,0,0)
        ContentFrame.Position = UDim2.new(0,5,0,0)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Visible = false
        ContentFrame.Parent = ContentScroll

        local Layout = Instance.new("UIListLayout")
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0,5)
        Layout.Parent = ContentFrame

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            ContentFrame.Size = UDim2.new(1,-10,0,Layout.AbsoluteContentSize.Y + 10)
        end)

        Btn.MouseButton1Click:Connect(function()
            for _,v in pairs(Tabs) do
                v.Frame.Visible = false
            end
            ContentFrame.Visible = true
        end)

        local SubTab = {}

        function SubTab:Section(text)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1,0,0,20)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.fromRGB(100,180,255)
            Label.Font = Enum.Font.GothamBold
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = ContentFrame

            local Divider = Instance.new("Frame")
            Divider.Size = UDim2.new(1,0,0,1)
            Divider.BackgroundColor3 = Color3.fromRGB(60,60,75)
            Divider.BorderSizePixel = 0
            Divider.Parent = ContentFrame
        end

        function SubTab:Button(text, callback)
            local Btn2 = Instance.new("TextButton")
            Btn2.Size = UDim2.new(1,0,0,25)
            Btn2.BackgroundColor3 = Color3.fromRGB(60,60,75)
            Btn2.Text = text
            Btn2.TextColor3 = Color3.fromRGB(255,255,255)
            Btn2.Font = Enum.Font.GothamBold
            Btn2.TextSize = 14
            Btn2.Parent = ContentFrame
            Instance.new("UICorner", Btn2)

            Btn2.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        function SubTab:Toggle(text, default, callback)
            local state = default
            local Btn2 = Instance.new("TextButton")
            Btn2.Size = UDim2.new(1,0,0,25)
            Btn2.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
            Btn2.Text = text
            Btn2.TextColor3 = Color3.fromRGB(255,255,255)
            Btn2.Font = Enum.Font.GothamBold
            Btn2.TextSize = 14
            Btn2.Parent = ContentFrame
            Instance.new("UICorner", Btn2)

            Btn2.MouseButton1Click:Connect(function()
                state = not state
                Btn2.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
                pcall(function() callback(state) end)
            end)
        end

        Tabs[name] = {Frame = ContentFrame}

        return SubTab
    end

    return mainTab
end

-- ===============================
-- Example Usage
-- ===============================
local MainTab = KaLiHub:CreateTab("Main")
local Sub1 = MainTab:Button("Features")
Sub1:Button("Test Button", function() print("Clicked!") end)
Sub1:Toggle("Auto Farm", false, function(v) print("Toggle:",v) end)

local PlayerTab = KaLiHub:CreateTab("Player")
local Sub2 = PlayerTab:Button("Player Options")
Sub2:Button("Speed Boost", function()
    local char = Player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.WalkSpeed = 50
    end
end)

return KaLiHub
