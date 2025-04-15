local Linux = {}

local TweenService = game:GetService("TweenService")

function Linux.Create(config)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = config.SizeMobile or UDim2.fromOffset(400, 250)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TitleLabel.Text = config.Name or "UI"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = MainFrame

    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Size = UDim2.new(1, 0, 0, 20)
    SubtitleLabel.Position = UDim2.new(0, 0, 0, 30)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = config.Subtitle or ""
    SubtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
    SubtitleLabel.TextSize = 12
    SubtitleLabel.Font = Enum.Font.SourceSans
    SubtitleLabel.Parent = MainFrame

    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0, config.TabWidth or 125, 1, -50)
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabContainer
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.FillDirection = Enum.FillDirection.Vertical
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -config.TabWidth, 1, -50)
    ContentFrame.Position = UDim2.new(0, config.TabWidth, 0, 50)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame

    local tabs = {}
    local currentTab = nil

    function tabs:Tab(tabConfig)
        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.Parent = ContentFrame

        local ScrollFrame = Instance.new("ScrollingFrame")
        ScrollFrame.Size = UDim2.new(1, -10, 1, -10)
        ScrollFrame.Position = UDim2.new(0, 5, 0, 5)
        ScrollFrame.BackgroundTransparency = 1
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollFrame.ScrollBarThickness = 4
        ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 255)
        ScrollFrame.Parent = TabFrame

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = ScrollFrame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 8)
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        ScrollFrame.ChildAdded:Connect(function()
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
        end)

        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Text = tabConfig.Name
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 255)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Parent = TabContainer

        local TabUICorner = Instance.new("UICorner")
        TabUICorner.CornerRadius = UDim.new(0, 6)
        TabUICorner.Parent = TabButton

        if tabConfig.Icon and tabConfig.Icon.Enabled then
            local Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 20, 0, 20)
            Icon.Position = UDim2.new(0, 10, 0.5, -10)
            Icon.BackgroundTransparency = 1
            Icon.Image = tabConfig.Icon.Image
            Icon.Parent = TabButton
            TabButton.TextXAlignment = Enum.TextXAlignment.Right
        end

        TabButton.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Visible = false
            end
            TabFrame.Visible = true
            currentTab = TabFrame
        end)

        if not currentTab then
            TabFrame.Visible = true
            currentTab = TabFrame
        end

        local tab = {}

        function tab:Button(buttonConfig)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -10, 0, 35)
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Button.Text = buttonConfig.Name
            Button.TextColor3 = Color3.fromRGB(150, 150, 255)
            Button.TextSize = 14
            Button.Font = Enum.Font.SourceSansBold
            Button.Parent = ScrollFrame

            local ButtonUICorner = Instance.new("UICorner")
            ButtonUICorner.CornerRadius = UDim.new(0, 6)
            ButtonUICorner.Parent = Button

            local ButtonUIStroke = Instance.new("UIStroke")
            ButtonUIStroke.Color = Color3.fromRGB(60, 60, 60)
            ButtonUIStroke.Thickness = 1
            ButtonUIStroke.Parent = Button

            Button.MouseButton1Click:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                }):Play()
                wait(0.2)
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                }):Play()
                buttonConfig.Callback()
            end)
        end

        function tab:Toggle(toggleConfig)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -10, 0, 35)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = ScrollFrame

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = toggleConfig.Name
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 14
            ToggleLabel.Font = Enum.Font.SourceSans
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame

            local ToggleButton = Instance.new("Frame")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleButton.Parent = ToggleFrame

            local ToggleUICorner = Instance.new("UICorner")
            ToggleUICorner.CornerRadius = UDim.new(0, 10)
            ToggleUICorner.Parent = ToggleButton

            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
            ToggleCircle.Position = toggleConfig.Default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            ToggleCircle.BackgroundColor3 = toggleConfig.Default and Color3.fromRGB(150, 150, 255) or Color3.fromRGB(100, 100, 100)
            ToggleCircle.Parent = ToggleButton

            local CircleUICorner = Instance.new("UICorner")
            CircleUICorner.CornerRadius = UDim.new(0, 10)
            CircleUICorner.Parent = ToggleCircle

            local state = toggleConfig.Default

            ToggleButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    state = not state
                    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = state and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)
                    }):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
                        BackgroundColor3 = state and Color3.fromRGB(150, 150, 255) or Color3.fromRGB(100, 100, 100),
                        Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    }):Play()
                    toggleConfig.Callback(state)
                end
            end)
        end

        return tab
    end

    return tabs
end

return Linux
