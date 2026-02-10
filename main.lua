-- KaLiHub Universal Executor-Safe GUI
pcall(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    -- Wait for LocalPlayer
    local player
    repeat
        player = Players.LocalPlayer
        RunService.RenderStepped:Wait()
    until player

    local playerGui = player:WaitForChild("PlayerGui")

    -- Remove old GUI
    if game:GetService("CoreGui"):FindFirstChild("KaLiHub") then
        game:GetService("CoreGui").KaLiHub:Destroy()
    end

    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KaLiHub"
    ScreenGui.ResetOnSpawn = false
    -- Try CoreGui, fallback to PlayerGui
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then
        ScreenGui.Parent = playerGui
    end

    -- Main Window
    local Window = Instance.new("Frame")
    Window.Size = UDim2.new(0, 500, 0, 400)
    Window.Position = UDim2.new(0.5, -250, 0.5, -200)
    Window.BackgroundColor3 = Color3.fromRGB(30,30,35)
    Window.BorderSizePixel = 0
    Window.Parent = ScreenGui

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,30)
    Title.BackgroundColor3 = Color3.fromRGB(20,20,25)
    Title.Text = "KaLi Hub"
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20
    Title.Parent = Window

    -- Frames for Tabs & Content
    local TabsFrame = Instance.new("Frame")
    TabsFrame.Size = UDim2.new(0, 120, 1, -30)
    TabsFrame.Position = UDim2.new(0,0,0,30)
    TabsFrame.BackgroundColor3 = Color3.fromRGB(40,40,50)
    TabsFrame.BorderSizePixel = 0
    TabsFrame.Parent = Window

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1,-120,1,-30)
    ContentFrame.Position = UDim2.new(0,120,0,30)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35,35,45)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = Window

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

    local function createSection(parent, text)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1,-20,0,25)
        lbl.Position = UDim2.new(0,10,0,#parent:GetChildren()*30)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(150,200,255)
        lbl.Font = Enum.Font.SourceSansBold
        lbl.TextSize = 18
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = parent
        return lbl
    end

    local function createButton(parent, text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-20,0,30)
        btn.Position = UDim2.new(0,10,0,#parent:GetChildren()*35)
        btn.BackgroundColor3 = Color3.fromRGB(70,70,90)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 16
        btn.Parent = parent
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    local function createToggle(parent, text, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,-20,0,30)
        frame.Position = UDim2.new(0,10,0,#parent:GetChildren()*35)
        frame.BackgroundTransparency = 1
        frame.Parent = parent

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0.3,-5,1,0)
        toggleBtn.Position = UDim2.new(0.7,5,0,0)
        toggleBtn.BackgroundColor3 = default and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        toggleBtn.Text = ""
        toggleBtn.Parent = frame

        local state = default
        toggleBtn.MouseButton1Click:Connect(function()
            state = not state
            toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
            callback(state)
        end)
    end

    -- Pages
    local pages = {}

    local function createPage(name)
        local page = Instance.new("Frame")
        page.Size = UDim2.new(1,0,1,0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = ContentFrame

        local tabBtn = createTab(name)
        tabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(pages) do p.Visible = false end
            page.Visible = true
        end)

        pages[#pages+1] = page
        return page
    end

    -- Main Page
    local mainPage = createPage("Main")
    mainPage.Visible = true
    createSection(mainPage,"Features")
    createButton(mainPage,"Do Action",function() print("Main action executed!") end)
    createToggle(mainPage,"Enable Feature",false,function(state) print("Feature enabled:",state) end)

    -- Settings Page
    local settingsPage = createPage("Settings")
    createSection(settingsPage,"Options")
    createToggle(settingsPage,"Show Notifications",true,function(state) print("Notifications:",state) end)
    createButton(settingsPage,"Set Name",function() print("Name set!") end)

    -- Credits
    local credits = Instance.new("TextLabel")
    credits.Size = UDim2.new(1,-20,0,25)
    credits.Position = UDim2.new(0,10,1,-30)
    credits.BackgroundTransparency = 1
    credits.Text = "Created by YourName"
    credits.TextColor3 = Color3.fromRGB(150,200,255)
    credits.Font = Enum.Font.SourceSansBold
    credits.TextSize = 16
    credits.TextXAlignment = Enum.TextXAlignment.Left
    credits.Parent = Window
end)
