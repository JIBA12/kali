-- KaLiHub V2 - Mobile-Friendly Dropdown Tabs (Stable Version)

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
Main.Size = UDim2.new(0, 300, 0, 250) -- reduced height
Main.Position = UDim2.new(0.5, -150, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BackgroundTransparency = 0.05
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0,12)

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

-- Buttons
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
-- Dropdown Tabs
-- ===============================
local TabDropdown = Instance.new("Frame")
TabDropdown.Size = UDim2.new(1,-20,0,35)
TabDropdown.Position = UDim2.new(0,10,0,45)
TabDropdown.BackgroundColor3 = Color3.fromRGB(45,45,55)
TabDropdown.Parent = Main
Instance.new("UICorner", TabDropdown)

local SelectedTab = Instance.new("TextLabel")
SelectedTab.Size = UDim2.new(1,-30,1,0)
SelectedTab.Position = UDim2.new(0,5,0,0)
SelectedTab.BackgroundTransparency = 1
SelectedTab.Text = "Select Tab"
SelectedTab.TextColor3 = Color3.fromRGB(255,255,255)
SelectedTab.Font = Enum.Font.GothamBold
SelectedTab.TextSize = 14
SelectedTab.TextXAlignment = Enum.TextXAlignment.Left
SelectedTab.Parent = TabDropdown

local DropdownArrow = Instance.new("TextLabel")
DropdownArrow.Size = UDim2.new(0,20,1,0)
DropdownArrow.Position = UDim2.new(1,-25,0,0)
DropdownArrow.BackgroundTransparency = 1
DropdownArrow.Text = "▼"
DropdownArrow.TextColor3 = Color3.fromRGB(200,200,255)
DropdownArrow.Font = Enum.Font.GothamBold
DropdownArrow.TextSize = 14
DropdownArrow.Parent = TabDropdown

local DropdownFrame = Instance.new("Frame")
DropdownFrame.Size = UDim2.new(1,0,0,0)
DropdownFrame.Position = UDim2.new(0,0,1,0)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(40,40,50)
DropdownFrame.ClipsDescendants = true
DropdownFrame.Parent = TabDropdown
Instance.new("UICorner", DropdownFrame)

local DropdownLayout = Instance.new("UIListLayout", DropdownFrame)
DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder
DropdownLayout.Padding = UDim.new(0,2)

-- Keep track of all tab buttons
local DropdownButtons = {}

-- ===============================
-- Content Area
-- ===============================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-20,1,-90)
Content.Position = UDim2.new(0,10,0,85)
Content.BackgroundTransparency = 1
Content.Parent = Main

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
Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
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
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1,0,1,0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false
    TabFrame.Parent = Content

    local Tab = {}

    -- Create tab button
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1,0,0,25)
    TabButton.BackgroundTransparency = 1
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255,255,255)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 14
    TabButton.Parent = DropdownFrame

    -- Add to tracking table
    table.insert(DropdownButtons, TabButton)

    -- Button click
    TabButton.MouseButton1Click:Connect(function()
        for _,v in pairs(Tabs) do
            v.Visible = false
        end
        TabFrame.Visible = true
        SelectedTab.Text = name
        DropdownFrame.Size = UDim2.new(1,0,0,0) -- collapse dropdown
    end)

    Tabs[name] = TabFrame

    -- Section
    function Tab:Section(text)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1,0,0,20)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(100,180,255)
        Label.Font = Enum.Font.GothamBold
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = TabFrame
    end

    -- Button
    function Tab:Button(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,0,0,25)
        Btn.BackgroundColor3 = Color3.fromRGB(60,60,75)
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
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
        Btn.Parent = TabFrame
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

-- Dropdown toggle
TabDropdown.MouseButton1Click:Connect(function()
    if #DropdownButtons == 0 then return end
    if DropdownFrame.Size.Y.Offset == 0 then
        DropdownFrame.Size = UDim2.new(1,0,0, #DropdownButtons * 27)
    else
        DropdownFrame.Size = UDim2.new(1,0,0,0)
    end
end)

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
