-- KaLiHub Compact Mobile Version
pcall(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")

    -- Wait for player
    local player
    repeat
        player = Players.LocalPlayer
        RunService.RenderStepped:Wait()
    until player

    local playerGui = player:WaitForChild("PlayerGui")

    -- Remove old GUI
    if CoreGui:FindFirstChild("KaLiHub") then
        CoreGui.KaLiHub:Destroy()
    end

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "KaLiHub"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = playerGui end

    -- Main Window (SMALLER)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 320, 0, 260) -- smaller size
    window.AnchorPoint = Vector2.new(0.5, 0.5)
    window.Position = UDim2.new(0.5, 0, 0.5, 0) -- auto center
    window.BackgroundColor3 = Color3.fromRGB(25,25,30)
    window.BorderSizePixel = 0
    window.Parent = gui
    window.Active = true

    Instance.new("UICorner", window).CornerRadius = UDim.new(0,8)

    -- Top Bar (drag area)
    local top = Instance.new("Frame")
    top.Size = UDim2.new(1,0,0,35)
    top.BackgroundColor3 = Color3.fromRGB(18,18,22)
    top.BorderSizePixel = 0
    top.Parent = window
    Instance.new("UICorner", top).CornerRadius = UDim.new(0,8)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,1,0)
    title.BackgroundTransparency = 1
    title.Text = "KaLi Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.fromRGB(0,170,255)
    title.Parent = top

    -- Sidebar (smaller)
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0,90,1,-35)
    sidebar.Position = UDim2.new(0,0,0,35)
    sidebar.BackgroundColor3 = Color3.fromRGB(35,35,45)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = window

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0,4)
    tabLayout.Parent = sidebar

    -- Content
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1,-90,1,-35)
    content.Position = UDim2.new(0,90,0,35)
    content.BackgroundTransparency = 1
    content.Parent = window

    -- Pages system
    local pages = {}

    local function createPage(name)
        local page = Instance.new("Frame")
        page.Size = UDim2.new(1,0,1,0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = content

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0,6)
        layout.Parent = page

        local tab = Instance.new("TextButton")
        tab.Size = UDim2.new(1,0,0,32) -- smaller tab
        tab.Text = name
        tab.Font = Enum.Font.Gotham
        tab.TextSize = 12
        tab.TextColor3 = Color3.new(1,1,1)
        tab.BackgroundColor3 = Color3.fromRGB(55,55,70)
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
        btn.Size = UDim2.new(1,-10,0,32)
        btn.Text = text
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
        btn.MouseButton1Click:Connect(callback)
    end

    -- Pages
    local main = createPage("Main")
    main.Visible = true
    createButton(main, "Test", function()
        print("Clicked")
    end)

    local settings = createPage("Settings")
    createButton(settings, "Reset", function()
        print("Reset")
    end)

    ------------------------------------------------------------------
    -- MOBILE + PC DRAG SYSTEM
    ------------------------------------------------------------------
    local dragging = false
    local dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
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

    top.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

end)
