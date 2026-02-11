-- KaLiHub Key GUI

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

-- Remove old
pcall(function()
if CoreGui:FindFirstChild("KaLiKeyGUI") then
CoreGui.KaLiKeyGUI:Destroy()
end
end)

-- Load Jnkie
local Junkie = loadstring(game:HttpGet("[https://jnkie.com/sdk/library.lua"))(](https://jnkie.com/sdk/library.lua%22%29%29%28))
Junkie.service = "KaLiHubV3"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

local KEY_LINK = "[https://your-key-link.com](https://your-key-link.com)"
local REPO = "[https://raw.githubusercontent.com/JIBA12/kali/main/](https://raw.githubusercontent.com/JIBA12/kali/main/)"

-- GUI
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KaLiKeyGUI"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = CoreGui

local Bg = Instance.new("Frame")
Bg.Size = UDim2.new(0,300,0,170)
Bg.Position = UDim2.new(0.5,-150,0.5,-85)
Bg.BackgroundColor3 = Color3.fromRGB(30,30,35)
Bg.BorderSizePixel = 0
Bg.Parent = KeyGui
Instance.new("UICorner", Bg)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-20,0,30)
Title.Position = UDim2.new(0,10,0,10)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub Key System"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Bg

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1,-20,0,35)
TextBox.Position = UDim2.new(0,10,0,50)
TextBox.PlaceholderText = "Paste key here"
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.BackgroundColor3 = Color3.fromRGB(20,20,25)
TextBox.Parent = Bg
Instance.new("UICorner", TextBox)

local Feedback = Instance.new("TextLabel")
Feedback.Size = UDim2.new(1,-20,0,20)
Feedback.Position = UDim2.new(0,10,0,90)
Feedback.BackgroundTransparency = 1
Feedback.TextColor3 = Color3.fromRGB(255,100,100)
Feedback.Text = ""
Feedback.Parent = Bg

local BtnFrame = Instance.new("Frame")
BtnFrame.Size = UDim2.new(1,-20,0,35)
BtnFrame.Position = UDim2.new(0,10,0,115)
BtnFrame.BackgroundTransparency = 1
BtnFrame.Parent = Bg

local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0.33,-5,1,0)
Submit.Text = "Submit"
Submit.BackgroundColor3 = Color3.fromRGB(80,160,255)
Submit.Parent = BtnFrame
Instance.new("UICorner", Submit)

local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.new(0.33,-5,1,0)
GetKey.Position = UDim2.new(0.33,5,0,0)
GetKey.Text = "Get Key"
GetKey.BackgroundColor3 = Color3.fromRGB(50,200,255)
GetKey.Parent = BtnFrame
Instance.new("UICorner", GetKey)

local Exit = Instance.new("TextButton")
Exit.Size = UDim2.new(0.33,-5,1,0)
Exit.Position = UDim2.new(0.66,10,0,0)
Exit.Text = "Exit"
Exit.BackgroundColor3 = Color3.fromRGB(200,60,60)
Exit.Parent = BtnFrame
Instance.new("UICorner", Exit)

-- Buttons

GetKey.MouseButton1Click:Connect(function()
pcall(function()
game:GetService("GuiService"):OpenBrowserWindow(KEY_LINK)
end)
end)

Exit.MouseButton1Click:Connect(function()
KeyGui:Destroy()
end)

Submit.MouseButton1Click:Connect(function()
local key = TextBox.Text
Feedback.Text = "Checking..."

```
local result = Junkie.check_key(key)

if result.valid then
    getgenv().SCRIPT_KEY = key
    KeyGui:Destroy()
    loadstring(game:HttpGet(REPO .. "kalihub.lua"))()
else
    Feedback.Text = "Invalid key!"
end
```

end)
