-- KaLiHub Modern Redesign
pcall(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    -- Wait for LocalPlayer
    local player
    repeat
        player = Players.LocalPlayer
        RunService.RenderStepped:Wait()
    until player

    local playerGui = player:WaitForChild("PlayerGui")

    -- Remove old GUI
    local CoreGui = game:GetService("CoreGui")
    if CoreGui:FindFirstChild("KaLiHub") then
        CoreGui.KaLiHub:Destroy()
    end

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "KaLiHub"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = playerGui end

    -- Main Window
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 470, 0, 360)
    window.Position = UDim2.new(0.5, -260, 0.5, -180)
    window.BackgroundColor3 = Color3.fromRGB(24,24,30)
    window.BorderSizePixel = 2
    window.Parent = gui
    window.Active = true

    Instance.new("UICorner", window).CornerRadius = UDim.new(0,15)

    -- Top Bar
    local top = Instance.new("Frame")
    top.Size = UDim2.new(1,0,0,40)
    top.BackgroundColor3 = Color3.fromRGB(18,18,22)
    top.BorderSizePixel = 0
    top.Parent = window
    Instance.new("UICorner", top).CornerRadius = UDim.new(0,10)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-10,1,0)
    title.Position = UDim2.new(0,10,0,0)
    title.BackgroundTransparency = 1
    title.Text = "KaLi Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(0,170,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = top

    -- Dragging
    local dragging, dragStart, startPos
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0,140,1,-40)
    sidebar.Position = UDim2.new(0,0,0,40)
    sidebar.BackgroundColor3 = Color3.fromRGB(20,20,26)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = window

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0,6)
    tabLayout.Parent = sidebar

    -- Content Area
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1,-140,1,-40)
    content.Position = UDim2.new(0,140,0,40)
    content.BackgroundTransparency = 1
    content.Parent = window

    -- UI creators
    local pages = {}

    local function createPage(name)
        local page = Instance.new("Frame")
        page.Size = UDim2.new(1,0,1,0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = content

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0,8)
        layout.Parent = page

        local tab = Instance.new("TextButton")
        tab.Size = UDim2.new(1,0,0,40)
        tab.BackgroundColor3 = Color3.fromRGB(40,40,50)
        tab.Text = name
        tab.Font = Enum.Font.Gotham
        tab.TextSize = 14
        tab.TextColor3 = Color3.new(1,1,1)
        tab.Parent = sidebar
        Instance.new("UICorner", tab).CornerRadius = UDim.new(0,6)

        tab.MouseButton1Click:Connect(function()
            for _,p in pairs(pages) do p.Visible = false end
            page.Visible = true
        end)

        pages[#pages+1] = page
        return page
    end

    local function createButton(parent, text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-20,0,40)
        btn.BackgroundColor3 = Color3.fromRGB(45,45,60)
        btn.Text = text
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(callback)
    end

    local function createToggle(parent, text, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,-20,0,40)
        frame.BackgroundColor3 = Color3.fromRGB(45,45,60)
        frame.Parent = parent
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = Color3.new(1,1,1)
        label.Parent = frame

        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(0.3,-6,0.7,0)
        toggle.Position = UDim2.new(0.7,3,0.15,0)
        toggle.BackgroundColor3 = default and Color3.fromRGB(0,170,255) or Color3.fromRGB(70,70,80)
        toggle.Text = ""
        toggle.Parent = frame
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

        local state = default
        toggle.MouseButton1Click:Connect(function()
            state = not state
            toggle.BackgroundColor3 = state and Color3.fromRGB(0,170,255) or Color3.fromRGB(70,70,80)
            callback(state)
        end)
    end

    -- Pages
    local main = createPage("Main")
    main.Visible = true

    createButton(main, "Test Action", function()
        print("Action executed")
    end)

    createToggle(main, "Enable Feature", false, function(v)
        print("Feature:", v)
    end)

    local settings = createPage("Settings")

    createToggle(settings, "Notifications", true, function(v)
        print("Notifications:", v)
    end)

    createButton(settings, "Reset", function()
        print("Reset clicked")
    end)

end)
