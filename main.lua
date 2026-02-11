--// Services
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

--// Remove old
pcall(function()
if CoreGui:FindFirstChild("KaLiHub") then
CoreGui.KaLiHub:Destroy()
end
end)

--// ScreenGui (safe parent)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or CoreGui or PlayerGui

--// Main Window
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 360)
Main.Position = UDim2.new(0.5, -160, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(30,30,35)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

--// Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,40)
Header.BackgroundColor3 = Color3.fromRGB(45,45,55)
Header.BorderSizePixel = 0
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-80,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

--// Buttons
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,35,1,0)
Minimize.Position = UDim2.new(1,-70,0,0)
Minimize.Text = "-"
Minimize.BackgroundColor3 = Color3.fromRGB(70,170,255)
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,35,1,0)
Close.Position = UDim2.new(1,-35,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Close.TextColor3 = Color3.new(1,1,1)
Close.Parent = Header

--// Sidebar (Tabs)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,100,1,-40)
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3 = Color3.fromRGB(35,35,45)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = Sidebar
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-100,1,-40)
Content.Position = UDim2.new(0,100,0,40)
Content.BackgroundTransparency = 1
Content.Parent = Main

--// Tab System
local Pages = {}

local function CreateTab(name)
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1,0,0,40)
Button.Text = name
Button.BackgroundColor3 = Color3.fromRGB(45,45,55)
Button.TextColor3 = Color3.new(1,1,1)
Button.Parent = Sidebar

```
local Page = Instance.new("Frame")
Page.Size = UDim2.new(1,0,1,0)
Page.Visible = false
Page.BackgroundTransparency = 1
Page.Parent = Content

Button.MouseButton1Click:Connect(function()
    for _,p in pairs(Content:GetChildren()) do
        if p:IsA("Frame") then
            p.Visible = false
        end
    end
    Page.Visible = true
end)

table.insert(Pages, Page)
if #Pages == 1 then
    Page.Visible = true
end

return Page
```

end

--// Example Tabs
local MainTab = CreateTab("Main")
local PlayerTab = CreateTab("Player")
local SettingsTab = CreateTab("Settings")

--// Floating Circle
local Float = Instance.new("TextButton")
Float.Size = UDim2.new(0,60,0,60)
Float.Position = UDim2.new(0,20,0.5,-30)
Float.BackgroundColor3 = Color3.fromRGB(70,170,255)
Float.Text = "K"
Float.TextColor3 = Color3.new(1,1,1)
Float.Visible = false
Float.Parent = ScreenGui
Instance.new("UICorner", Float).CornerRadius = UDim.new(1,0)

--// Actions
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

--// Drag (Mobile + PC)
local function Drag(frame)
local dragging, startPos, startInput

```
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        startPos = frame.Position
        startInput = input.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - startInput
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
```

end

Drag(Main)
Drag(Float)
