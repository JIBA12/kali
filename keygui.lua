-- KaLiHub Key GUI
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer

-- Jnkie SDK
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "KaLiHubV3"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

-- Key GUI
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

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-20,0,30)
Title.Position = UDim2.new(0,10,0,10)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub Key System"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Bg

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

local Feedback = Instance.new("TextLabel")
Feedback.Size = UDim2.new(1,-20,0,20)
Feedback.Position = UDim2.new(0,10,0,90)
Feedback.BackgroundTransparency = 1
Feedback.TextColor3 = Color3.fromRGB(255,100,100)
Feedback.Font = Enum.Font.Gotham
Feedback.TextSize = 14
Feedback.Text = ""
Feedback.Parent = Bg

-- Buttons
local BtnFrame = Instance.new("Frame")
BtnFrame.Size = UDim2.new(1,-20,0,35)
BtnFrame.Position = UDim2.new(0,10,0,115)
BtnFrame.BackgroundTransparency = 1
BtnFrame.Parent = Bg

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

-- Actions
local KEY_LINK = "https://your-key-link.com"

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(KEY_LINK) end
    pcall(function()
        if syn and syn.open_url then syn.open_url(KEY_LINK)
        elseif fluxus and fluxus.open then fluxus.open(KEY_LINK)
        elseif game:GetService("GuiService").OpenBrowserWindow then
            game:GetService("GuiService"):OpenBrowserWindow(KEY_LINK)
        end
    end)
    Feedback.Text = "Link copied to clipboard!"
    Feedback.TextColor3 = Color3.fromRGB(100,255,100)
end)

ExitBtn.MouseButton1Click:Connect(function()
    KeyGui:Destroy()
end)

local function validateKey(key)
    return Junkie.check_key(key).valid
end

SubmitBtn.MouseButton1Click:Connect(function()
    local key = TextBox.Text
    if #key < 5 then
        Feedback.Text = "Key too short!"
        return
    end

    Feedback.Text = "Validating..."
    if validateKey(key) then
        if writefile then writefile("KaLiHub_Key.txt", key) end
        getgenv().SCRIPT_KEY = key
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JIBA12/kali/main/kalihub.lua"))()
        KeyGui:Destroy()
    else
        Feedback.Text = "Invalid key!"
    end
end)

