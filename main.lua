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

    -- Wait for PlayerGui
    local playerGui = player:WaitForChild("PlayerGui")

    -- Remove old GUI
    if playerGui:FindFirstChild("KaLiHub") then
        playerGui.KaLiHub:Destroy()
    end

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "KaLiHub"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    -- Main Frame
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 300, 0, 200)
    main.Position = UDim2.new(0.5, -150, 0.5, -100)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.BorderSizePixel = 0
    main.Active = true
    main.Parent = gui

    -- Title
    local title = Instance.new("TextButton")
    title.Size = UDim2.new(1,0,0,30)
    title.BackgroundColor3 = Color3.fromRGB(40,40,40)
    title.Text = "KaLi Hub"
    title.TextColor3 = Color3.fromRGB(0,170,255)
    title.BorderSizePixel = 0
    title.Parent = main

    -- Minimize
    local minimize = Instance.new("TextButton")
    minimize.Size = UDim2.new(0,30,0,30)
    minimize.Position = UDim2.new(1,-30,0,0)
    minimize.Text = "-"
    minimize.BackgroundColor3 = Color3.fromRGB(60,60,60)
    minimize.TextColor3 = Color3.new(1,1,1)
    minimize.BorderSizePixel = 0
    minimize.Parent = main

    -- Floating Button
    local float = Instance.new("TextButton")
    float.Size = UDim2.new(0,50,0,50)
    float.Position = UDim2.new(0,100,0,100)
    float.Text = "KaLi"
    float.Visible = false
    float.BackgroundColor3 = Color3.fromRGB(0,170,255)
    float.TextColor3 = Color3.new(1,1,1)
    float.BorderSizePixel = 0
    float.Parent = gui

    -- Example Button
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-20,0,40)
    btn.Position = UDim2.new(0,10,0,50)
    btn.Text = "Test Button"
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    btn.Parent = main

    btn.MouseButton1Click:Connect(function()
        print("Button works!")
    end)

    -- Minimize / Restore
    minimize.MouseButton1Click:Connect(function()
        main.Visible = false
        float.Visible = true
    end)

    float.MouseButton1Click:Connect(function()
        main.Visible = true
        float.Visible = false
    end)

    -- Draggable function
    local function makeDraggable(frame)
        local dragging = false
        local dragInput, startPos, startMousePos

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                startMousePos = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - startMousePos
                frame.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    makeDraggable(title)
    makeDraggable(float)
end)
