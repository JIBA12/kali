-- ============================================
-- KaLiHub V3 – Key System + Mobile-Friendly GUI
-- ============================================

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ==================
-- Forward declaration
-- ==================
local loadKaLiHub

-- ==================
-- Load Jnkie SDK
-- ==================
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "KaLiHubV3"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

-- ==================
-- KEY PROMPT GUI
-- ==================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KaLiKeyGUI"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = CoreGui

-- Background
local Bg = Instance.new("Frame")
Bg.Size = UDim2.new(0, 280, 0, 140)
Bg.Position = UDim2.new(0.5, -140, 0.5, -70)
Bg.BackgroundColor3 = Color3.fromRGB(30,30,35)
Bg.BorderSizePixel = 0
Bg.Parent = KeyGui
Instance.new("UICorner", Bg)

-- Title
local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1,-20,0,30)
Label.Position = UDim2.new(0,10,0,10)
Label.BackgroundTransparency = 1
Label.Text = "Enter Script Key"
Label.TextColor3 = Color3.fromRGB(255,255,255)
Label.Font = Enum.Font.GothamBold
Label.TextSize = 18
Label.Parent = Bg

-- TextBox
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1,-20,0,35)
TextBox.Position = UDim2.new(0,10,0,50)
TextBox.PlaceholderText = "Paste your key here"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255,255,255)
TextBox.BackgroundColor3 = Color3.fromRGB(20,20,25)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 16
TextBox.Parent = Bg
Instance.new("UICorner", TextBox)

-- Submit Button
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0,100,0,30)
SubmitBtn.Position = UDim2.new(1,-110,1,-40)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(80,160,255)
SubmitBtn.Text = "Submit"
SubmitBtn.TextColor3 = Color3.fromRGB(255,255,255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 16
SubmitBtn.Parent = Bg
Instance.new("UICorner", SubmitBtn)

-- Feedback Label
local Feedback = Instance.new("TextLabel")
Feedback.Size = UDim2.new(1,-20,0,20)
Feedback.Position = UDim2.new(0,10,0,90)
Feedback.BackgroundTransparency = 1
Feedback.TextColor3 = Color3.fromRGB(255,100,100)
Feedback.Font = Enum.Font.Gotham
Feedback.TextSize = 14
Feedback.Text = ""
Feedback.Parent = Bg

-- Validate Key Function
local function validateKey(key)
    local result = Junkie.check_key(key)
    return result
end

-- ==================
-- MAIN KaLiHub GUI
-- ==================
loadKaLiHub = function()

    -- Remove old GUI
    pcall(function()
        if CoreGui:FindFirstChild("KaLiHubV3") then
            CoreGui.KaLiHubV3:Destroy()
        end
    end)

    local parentGui = CoreGui or PlayerGui
    local HEADER_HEIGHT = 35

    -- ScreenGui + Main Frame
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KaLiHubV3"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = parentGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 320, 0, 200)
    Main.Position = UDim2.new(0.5, -160, 0.5, -100)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,30)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main)
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = Color3.fromRGB(80,160,255)
    MainStroke.Thickness = 1

    -- Header + Title + Buttons
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1,0,0,HEADER_HEIGHT)
    Header.BackgroundTransparency = 1
    Header.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,-70,1,0)
    Title.Position = UDim2.new(0,10,0,0)
    Title.BackgroundTransparency = 1
    Title.Text = "KaLiHub V3"
    Title.TextColor3 = Color3.fromRGB(200,200,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 12
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

    -- Header Line
    local HeaderLine = Instance.new("Frame")
    HeaderLine.Size = UDim2.new(1,0,0,1)
    HeaderLine.Position = UDim2.new(0,0,0,HEADER_HEIGHT-1)
    HeaderLine.BackgroundColor3 = Color3.fromRGB(80,160,255)
    HeaderLine.BorderSizePixel = 0
    HeaderLine.Parent = Main

    -- ===============
    -- TABS & SECTIONS
    -- ===============
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(0, 100, 1, -HEADER_HEIGHT)
    TabFrame.Position = UDim2.new(0,0,0,HEADER_HEIGHT)
    TabFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
    TabFrame.BorderSizePixel = 0
    TabFrame.Parent = Main
    Instance.new("UICorner", TabFrame)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -100, 1, -HEADER_HEIGHT)
    ContentFrame.Position = UDim2.new(0,100,0,HEADER_HEIGHT)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30,30,35)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = Main
    Instance.new("UICorner", ContentFrame)

    -- Example Tabs
    local tabs = {"Home", "Scripts", "Settings"}
    local tabButtons = {}
    for i, name in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.Position = UDim2.new(0,5,0,(i-1)*40+5)
        btn.BackgroundColor3 = Color3.fromRGB(50,50,55)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Parent = TabFrame
        Instance.new("UICorner", btn)
        tabButtons[name] = btn

        btn.MouseButton1Click:Connect(function()
            -- Clear previous content
            for _, child in ipairs(ContentFrame:GetChildren()) do
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end
            -- Add new content
            local page = Instance.new("Frame")
            page.Size = UDim2.new(1,0,1,0)
            page.BackgroundTransparency = 1
            page.Parent = ContentFrame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,1,0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.Font = Enum.Font.Gotham
            label.TextSize = 16
            label.Text = "Welcome to "..name.." page!"
            label.Parent = page
        end)
    end

    -- ===============
    -- Draggable Function
    -- ===============
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

    -- ===============
    -- Minimize / Close
    -- ===============
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

    -- Load default tab
    tabButtons["Home"]:Activate()
end

-- ==================
-- Submit Button
-- ==================
SubmitBtn.MouseButton1Click:Connect(function()
    local key = TextBox.Text
    if #key < 5 then
        Feedback.Text = "Key too short!"
        return
    end

    Feedback.Text = "Validating..."
    local result = validateKey(key)
    if result.valid then
        getgenv().SCRIPT_KEY = key
        KeyGui:Destroy()
        loadKaLiHub()
    else
        Feedback.Text = "Invalid key!"
    end
end)
