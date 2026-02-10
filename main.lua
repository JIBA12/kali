-- ===== Executor-safe KaLi Hub GUI (Fixed Layout) =====
local player = game:GetService("Players").LocalPlayer
local playerGui = player:FindFirstChild("PlayerGui")

-- Remove old GUI if exists
if playerGui:FindFirstChild("KaLiHub") then
    playerGui.KaLiHub:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHub"
ScreenGui.Parent = playerGui

-- ===== Main Window =====
local Window = Instance.new("Frame")
Window.Size = UDim2.new(0,500,0,400)
Window.Position = UDim2.new(0.5,-250,0.5,-200)
Window.BackgroundColor3 = Color3.fromRGB(30,30,35)
Window.BorderSizePixel = 0
Window.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-30,0,30)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundColor3 = Color3.fromRGB(20,20,25)
Title.Text = "KaLi Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = Window

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0,30,0,30)
MinimizeBtn.Position = UDim2.new(1,-30,0,0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 20
MinimizeBtn.Parent = Window

-- Floating Icon
local FloatingIcon = Instance.new("TextButton")
FloatingIcon.Size = UDim2.new(0,50,0,50)
FloatingIcon.Position = UDim2.new(0.1,0,0.1,0)
FloatingIcon.BackgroundColor3 = Color3.fromRGB(50,50,60)
FloatingIcon.Text = "KaLi"
FloatingIcon.TextColor3 = Color3.fromRGB(255,255,255)
FloatingIcon.Font = Enum.Font.SourceSansBold
FloatingIcon.TextSize = 18
FloatingIcon.Visible = false
FloatingIcon.Parent = ScreenGui

-- ===== Draggable Function =====
local function makeDraggable(frame)
    local dragging = false
    local dragStart = Vector2.new(0,0)
    local startPos = Vector2.new(0,0)
    local mouse = player:GetMouse()

    frame.MouseButton1Down:Connect(function()
        dragging = true
        dragStart = Vector2.new(mouse.X, mouse.Y)
        startPos = Vector2.new(frame.Position.X.Offset, frame.Position.Y.Offset)
    end)

    mouse.Move:Connect(function()
        if dragging then
            local delta = Vector2.new(mouse.X, mouse.Y) - dragStart
            frame.Position = UDim2.new(0, startPos.X + delta.X, 0, startPos.Y + delta.Y)
        end
    end)

    mouse.Button1Up:Connect(function()
        dragging = false
    end)
end

makeDraggable(Window)
makeDraggable(FloatingIcon)

-- ===== Minimize / Restore =====
MinimizeBtn.MouseButton1Click:Connect(function()
    Window.Visible = false
    FloatingIcon.Visible = true
end)

FloatingIcon.MouseButton1Click:Connect(function()
    FloatingIcon.Visible = false
    Window.Visible = true
end)

-- ===== Tabs & Content =====
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(0,120,1,-30)
TabsFrame.Position = UDim2.new(0,0,0,30)
TabsFrame.BackgroundColor3 = Color3.fromRGB(40,40,50)
TabsFrame.Parent = Window

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1,-120,1,-30)
ContentFrame.Position = UDim2.new(0,120,0,30)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35,35,45)
ContentFrame.Parent = Window

-- Add UIListLayout to automatically position buttons
local mainLayout = Instance.new("UIListLayout")
mainLayout.Padding = UDim.new(0,5)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Parent = ContentFrame

-- Helper functions
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,50)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,70)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = TabsFrame
    return btn
end

local function createButton(parent,text,callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-10,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,90)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ===== Main Page =====
local mainPage = Instance.new("Frame")
mainPage.Size = UDim2.new(1,0,1,0)
mainPage.BackgroundTransparency = 1
mainPage.Parent = ContentFrame

local mainTabBtn = createTab("Main")
mainTabBtn.MouseButton1Click:Connect(function()
    mainPage.Visible = true
end)

createButton(mainPage,"Do Action",function()
    print("Main action executed!")
end)
