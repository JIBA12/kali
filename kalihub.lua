-- ============================================
-- KaLiHub V3 Full Script (Optimized)
-- Key System + Get Key + Exit + Main GUI
-- ============================================

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Forward declare
local loadKaLiHub

-- ============================================
-- Load Jnkie SDK
-- ============================================
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "KaLiHubV3"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

-- ============================================
-- KEY SYSTEM GUI
-- ============================================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KaLiKeyGUI"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = CoreGui

local Bg = Instance.new("Frame")
Bg.Size = UDim2.new(0, 300, 0, 170)
Bg.Position = UDim2.new(0.5, -150, 0.5, -85)
Bg.BackgroundColor3 = Color3.fromRGB(30,30,35)
Bg.BorderSizePixel = 0
Bg.Parent = KeyGui
Instance.new("UICorner", Bg)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-20,0,30)
Title.Position = UDim2.new(0,10,0,10)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub Key System"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Bg

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

-- Feedback
local Feedback = Instance.new("TextLabel")
Feedback.Size = UDim2.new(1,-20,0,20)
Feedback.Position = UDim2.new(0,10,0,90)
Feedback.BackgroundTransparency = 1
Feedback.TextColor3 = Color3.fromRGB(255,100,100)
Feedback.Font = Enum.Font.Gotham
Feedback.TextSize = 14
Feedback.Text = ""
Feedback.Parent = Bg

-- Buttons Container
local BtnFrame = Instance.new("Frame")
BtnFrame.Size = UDim2.new(1,-20,0,35)
BtnFrame.Position = UDim2.new(0,10,0,115)
BtnFrame.BackgroundTransparency = 1
BtnFrame.Parent = Bg

-- Submit
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.33,-5,1,0)
SubmitBtn.Position = UDim2.new(0,0,0,0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(80,160,255)
SubmitBtn.Text = "Submit"
SubmitBtn.TextColor3 = Color3.fromRGB(255,255,255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.Parent = BtnFrame
Instance.new("UICorner", SubmitBtn)

-- Get Key
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.33,-5,1,0)
GetKeyBtn.Position = UDim2.new(0.33,5,0,0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(50,200,255)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 14
GetKeyBtn.Parent = BtnFrame
Instance.new("UICorner", GetKeyBtn)

-- Exit
local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0.33,-5,1,0)
ExitBtn.Position = UDim2.new(0.66,10,0,0)
ExitBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
ExitBtn.Text = "Exit"
ExitBtn.TextColor3 = Color3.fromRGB(255,255,255)
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.TextSize = 14
ExitBtn.Parent = BtnFrame
Instance.new("UICorner", ExitBtn)

-- ============================================
-- Button Actions
-- ============================================

-- Replace with your real key link
local KEY_LINK = "https://your-key-link.com"

GetKeyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if syn and syn.request then
            syn.request({Url = KEY_LINK, Method = "GET"})
        else
            game:GetService("GuiService"):OpenBrowserWindow(KEY_LINK)
        end
    end)
end)

ExitBtn.MouseButton1Click:Connect(function()
    KeyGui:Destroy()
end)

local function validateKey(key)
    local result = Junkie.check_key(key)
    return result
end

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

-- ============================================
-- MAIN KALIHUB GUI
-- ============================================
loadKaLiHub = function()

    -- Remove old
    pcall(function()
        if CoreGui:FindFirstChild("KaLiHubV3") then
            CoreGui.KaLiHubV3:Destroy()
        end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KaLiHubV3"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui or PlayerGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0,320,0,200)
    Main.Position = UDim2.new(0.5,-160,0.5,-100)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,30)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main)

    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1,0,0,35)
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

    -- Minimize
    local Minimize = Instance.new("TextButton")
    Minimize.Size = UDim2.new(0,30,0,25)
    Minimize.Position = UDim2.new(1,-70,0,5)
    Minimize.Text = "-"
    Minimize.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Minimize.TextColor3 = Color3.new(1,1,1)
    Minimize.Parent = Header
    Instance.new("UICorner", Minimize)

    -- Close
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0,30,0,25)
    Close.Position = UDim2.new(1,-35,0,5)
    Close.Text = "X"
    Close.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Close.TextColor3 = Color3.new(1,1,1)
    Close.Parent = Header
    Instance.new("UICorner", Close)

    -- Draggable
    local dragging, dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Floating button
    local Floating

    Minimize.MouseButton1Click:Connect(function()
        Main.Visible = false
        if Floating then return end

        Floating = Instance.new("TextButton")
        Floating.Size = UDim2.new(0,35,0,35)
        Floating.Position = UDim2.new(0.5,-20,0.5,-20)
        Floating.BackgroundColor3 = Color3.fromRGB(80,160,255)
        Floating.Text = "K"
        Floating.TextColor3 = Color3.new(1,1,1)
        Floating.Parent = ScreenGui
        Instance.new("UICorner", Floating)

        Floating.MouseButton1Click:Connect(function()
            Main.Visible = true
            Floating:Destroy()
            Floating = nil
        end)
    end)

    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end
