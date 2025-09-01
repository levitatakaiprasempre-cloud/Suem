-- Script para Delta Executor - Saber Showdown
-- Funcionalidades: Kill Aura, Anti Slap, Farm de Pontos
-- GUI estilo Dragon Ball para mobile

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

-- Configurações iniciais
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local guiEnabled = true
local killAuraEnabled = true
local antiSlapEnabled = true
local farmPointsEnabled = true
local backgroundMode = true

-- Criar a GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnimeGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 10
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal (dragável)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 350)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Header com estilo Dragon Ball
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
}
headerGradient.Rotation = 90
headerGradient.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SABER SHOWDOWN"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = header

-- Botão para minimizar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -40, 0, 0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 20
minimizeButton.Parent = header

-- Container de abas
local tabsContainer = Instance.new("Frame")
tabsContainer.Name = "TabsContainer"
tabsContainer.Size = UDim2.new(1, 0, 0, 40)
tabsContainer.Position = UDim2.new(0, 0, 0, 40)
tabsContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabsContainer.BorderSizePixel = 0
tabsContainer.Parent = mainFrame

-- Conteúdo das abas
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -80)
contentFrame.Position = UDim2.new(0, 0, 0, 80)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Criar abas
local tabs = {"Combat", "Farm", "Settings"}
local currentTab = "Combat"

local function createTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1/#tabs, 0, 1, 0)
    tabButton.Position = UDim2.new((#tabs-1)/#tabs, 0, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButton.BorderSizePixel = 0
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.Parent = tabsContainer
    
    return tabButton
end

-- Conteúdo para cada aba
local function createCombatTab()
    local combatFrame = Instance.new("Frame")
    combatFrame.Name = "CombatFrame"
    combatFrame.Size = UDim2.new(1, 0, 1, 0)
    combatFrame.Position = UDim2.new(0, 0, 0, 0)
    combatFrame.BackgroundTransparency = 1
    combatFrame.Visible = currentTab == "Combat"
    combatFrame.Parent = contentFrame
    
    -- Kill Aura
    local killAuraToggle = Instance.new("TextButton")
    killAuraToggle.Name = "KillAuraToggle"
    killAuraToggle.Size = UDim2.new(0.8, 0, 0, 40)
    killAuraToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
    killAuraToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    killAuraToggle.BorderSizePixel = 0
    killAuraToggle.Text = "Kill Aura: OFF"
    killAuraToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    killAuraToggle.Font = Enum.Font.GothamBold
    killAuraToggle.TextSize = 16
    killAuraToggle.Parent = combatFrame
    
    -- Anti Slap
    local antiSlapToggle = Instance.new("TextButton")
    antiSlapToggle.Name = "AntiSlapToggle"
    antiSlapToggle.Size = UDim2.new(0.8, 0, 0, 40)
    antiSlapToggle.Position = UDim2.new(0.1, 0, 0.3, 0)
    antiSlapToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    antiSlapToggle.BorderSizePixel = 0
    antiSlapToggle.Text = "Anti Slap: OFF"
    antiSlapToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    antiSlapToggle.Font = Enum.Font.GothamBold
    antiSlapToggle.TextSize = 16
    antiSlapToggle.Parent = combatFrame
    
    -- Slider de alcance do Kill Aura
    local rangeLabel = Instance.new("TextLabel")
    rangeLabel.Name = "RangeLabel"
    rangeLabel.Size = UDim2.new(0.8, 0, 0, 20)
    rangeLabel.Position = UDim2.new(0.1, 0, 0.5, 0)
    rangeLabel.BackgroundTransparency = 1
    rangeLabel.Text = "Kill Aura Range: 20"
    rangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    rangeLabel.Font = Enum.Font.Gotham
    rangeLabel.TextSize = 14
    rangeLabel.TextXAlignment = Enum.TextXAlignment.Left
    rangeLabel.Parent = combatFrame
    
    local rangeSlider = Instance.new("Frame")
    rangeSlider.Name = "RangeSlider"
    rangeSlider.Size = UDim2.new(0.8, 0, 0, 10)
    rangeSlider.Position = UDim2.new(0.1, 0, 0.6, 0)
    rangeSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    rangeSlider.BorderSizePixel = 0
    rangeSlider.Parent = combatFrame
    
    local rangeFill = Instance.new("Frame")
    rangeFill.Name = "RangeFill"
    rangeFill.Size = UDim2.new(0.5, 0, 1, 0)
    rangeFill.Position = UDim2.new(0, 0, 0, 0)
    rangeFill.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    rangeFill.BorderSizePixel = 0
    rangeFill.Parent = rangeSlider
    
    local rangeButton = Instance.new("TextButton")
    rangeButton.Name = "RangeButton"
    rangeButton.Size = UDim2.new(1, 0, 1, 0)
    rangeButton.Position = UDim2.new(0, 0, 0, 0)
    rangeButton.BackgroundTransparency = 1
    rangeButton.Text = ""
    rangeButton.Parent = rangeSlider
    
    return combatFrame, killAuraToggle, antiSlapToggle, rangeLabel, rangeFill, rangeButton
end

local function createFarmTab()
    local farmFrame = Instance.new("Frame")
    farmFrame.Name = "FarmFrame"
    farmFrame.Size = UDim2.new(1, 0, 1, 0)
    farmFrame.Position = UDim2.new(0, 0, 0, 0)
    farmFrame.BackgroundTransparency = 1
    farmFrame.Visible = currentTab == "Farm"
    farmFrame.Parent = contentFrame
    
    -- Farm de Pontos
    local farmToggle = Instance.new("TextButton")
    farmToggle.Name = "FarmToggle"
    farmToggle.Size = UDim2.new(0.8, 0, 0, 40)
    farmToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
    farmToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    farmToggle.BorderSizePixel = 0
    farmToggle.Text = "Farm Points: OFF"
    farmToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    farmToggle.Font = Enum.Font.GothamBold
    farmToggle.TextSize = 16
    farmToggle.Parent = farmFrame
    
    -- Informações de Farm
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "InfoLabel"
    infoLabel.Size = UDim2.new(0.8, 0, 0, 100)
    infoLabel.Position = UDim2.new(0.1, 0, 0.3, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "Farm Status: Inactive\nPoints Collected: 0\nPlayers Defeated: 0"
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 14
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.TextYAlignment = Enum.TextYAlignment.Top
    infoLabel.Parent = farmFrame
    
    return farmFrame, farmToggle, infoLabel
end

local function createSettingsTab()
    local settingsFrame = Instance.new("Frame")
    settingsFrame.Name = "SettingsFrame"
    settingsFrame.Size = UDim2.new(1, 0, 1, 0)
    settingsFrame.Position = UDim2.new(0, 0, 0, 0)
    settingsFrame.BackgroundTransparency = 1
    settingsFrame.Visible = currentTab == "Settings"
    settingsFrame.Parent = contentFrame
    
    -- Modo segundo plano
    local backgroundToggle = Instance.new("TextButton")
    backgroundToggle.Name = "BackgroundToggle"
    backgroundToggle.Size = UDim2.new(0.8, 0, 0, 40)
    backgroundToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
    backgroundToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    backgroundToggle.BorderSizePixel = 0
    backgroundToggle.Text = "Background Mode: OFF"
    backgroundToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    backgroundToggle.Font = Enum.Font.GothamBold
    backgroundToggle.TextSize = 16
    backgroundToggle.Parent = settingsFrame
    
    -- Botão para fechar a GUI
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.8, 0, 0, 40)
    closeButton.Position = UDim2.new(0.1, 0, 0.3, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "Close GUI"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.Parent = settingsFrame
    
    -- Créditos
    local creditsLabel = Instance.new("TextLabel")
    creditsLabel.Name = "CreditsLabel"
    creditsLabel.Size = UDim2.new(0.8, 0, 0, 60)
    creditsLabel.Position = UDim2.new(0.1, 0, 0.7, 0)
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.Text = "Dragon Ball GUI\nScript for Delta Executor\nSaber Showdown"
    creditsLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
    creditsLabel.Font = Enum.Font.Gotham
    creditsLabel.TextSize = 14
    creditsLabel.Parent = settingsFrame
    
    return settingsFrame, backgroundToggle, closeButton
end

-- Criar as abas e elementos da GUI
local tabButtons = {}
for i, tabName in ipairs(tabs) do
    local tabButton = createTab(tabName)
    tabButton.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    tabButtons[tabName] = tabButton
end

local combatFrame, killAuraToggle, antiSlapToggle, rangeLabel, rangeFill, rangeButton = createCombatTab()
local farmFrame, farmToggle, infoLabel = createFarmTab()
local settingsFrame, backgroundToggle, closeButton = createSettingsTab()

-- Variáveis para funcionalidades
local killAuraRange = 20
local pointsCollected = 0
local playersDefeated = 0

-- Função para atualizar a GUI
local function updateGUI()
    killAuraToggle.Text = "Kill Aura: " .. (killAuraEnabled and "ON" or "OFF")
    killAuraToggle.TextColor3 = killAuraEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    antiSlapToggle.Text = "Anti Slap: " .. (antiSlapEnabled and "ON" or "OFF")
    antiSlapToggle.TextColor3 = antiSlapEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    farmToggle.Text = "Farm Points: " .. (farmPointsEnabled and "ON" or "OFF")
    farmToggle.TextColor3 = farmPointsEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    backgroundToggle.Text = "Background Mode: " .. (backgroundMode and "ON" or "OFF")
    backgroundToggle.TextColor3 = backgroundMode and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    rangeLabel.Text = "Kill Aura Range: " .. math.floor(killAuraRange)
    rangeFill.Size = UDim2.new(killAuraRange/40, 0, 1, 0)
    
    infoLabel.Text = "Farm Status: " .. (farmPointsEnabled and "Active" or "Inactive") .. 
                    "\nPoints Collected: " .. pointsCollected .. 
                    "\nPlayers Defeated: " .. playersDefeated
end

-- Função para trocar de aba
local function switchTab(tabName)
    currentTab = tabName
    combatFrame.Visible = tabName == "Combat"
    farmFrame.Visible = tabName == "Farm"
    settingsFrame.Visible = tabName == "Settings"
    
    for name, button in pairs(tabButtons) do
        button.BackgroundColor3 = name == tabName and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(50, 50, 50)
    end
end

-- Conexão de eventos
killAuraToggle.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    updateGUI()
end)

antiSlapToggle.MouseButton1Click:Connect(function()
    antiSlapEnabled = not antiSlapEnabled
    updateGUI()
end)

farmToggle.MouseButton1Click:Connect(function()
    farmPointsEnabled = not farmPointsEnabled
    updateGUI()
end)

backgroundToggle.MouseButton1Click:Connect(function()
    backgroundMode = not backgroundMode
    if backgroundMode then
        mainFrame.Visible = false
    end
    updateGUI()
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    guiEnabled = false
end)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

for tabName, button in pairs(tabButtons) do
    button.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)
end

-- Controle do slider de alcance
local sliding = false
rangeButton.MouseButton1Down:Connect(function()
    sliding = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliding = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
        local xPos = math.clamp(input.Position.X - rangeSlider.AbsolutePosition.X, 0, rangeSlider.AbsoluteSize.X)
        killAuraRange = math.floor((xPos / rangeSlider.AbsoluteSize.X) * 40)
        updateGUI()
    end
end)

-- Inicializar GUI
updateGUI()
switchTab("Combat")

-- Função para encontrar o jogador mais próximo
local function getNearestPlayer(maxDistance)
    local nearestPlayer = nil
    local nearestDistance = maxDistance
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < nearestDistance then
                nearestPlayer = player
                nearestDistance = distance
            end
        end
    end
    
    return nearestPlayer, nearestDistance
end

-- Função Kill Aura
local killAuraConnection
local function startKillAura()
    if killAuraConnection then
        killAuraConnection:Disconnect()
    end
    
    killAuraConnection = RunService.Heartbeat:Connect(function()
        if not killAuraEnabled or not Players.LocalPlayer.Character or not Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local nearestPlayer, distance = getNearestPlayer(killAuraRange)
        if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("Humanoid") then
            -- Simular ataque (ajuste conforme a mecânica do jogo)
            local humanoid = nearestPlayer.Character.Humanoid
            humanoid:TakeDamage(humanoid.Health)
            playersDefeated = playersDefeated + 1
            updateGUI()
        end
    end)
end

-- Função Anti Slap
local antiSlapConnection
local function startAntiSlap()
    if antiSlapConnection then
        antiSlapConnection:Disconnect()
    end
    
    antiSlapConnection = Players.LocalPlayer.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            if antiSlapEnabled then
                -- Lógica para evitar morte por slap (ajuste conforme o jogo)
                wait(1)
                if Players.LocalPlayer.Character then
                    Players.LocalPlayer.Character:BreakJoints()
                end
            end
        end)
    end)
end

-- Função Farm de Pontos
local farmConnection
local function startFarmPoints()
    if farmConnection then
        farmConnection:Disconnect()
    end
    
    farmConnection = RunService.Heartbeat:Connect(function()
        if not farmPointsEnabled or not Players.LocalPlayer.Character then
            return
        end
        
        -- Lógica para farmar pontos (ajuste conforme a mecânica do jogo)
        local nearestPlayer, distance = getNearestPlayer(50)
        if nearestPlayer and distance < 10 then
            -- Simular coleta de pontos ao derrotar jogadores
            pointsCollected = pointsCollected + 10
            updateGUI()
        end
    end)
end

-- Iniciar as funcionalidades
startKillAura()
startAntiSlap()
startFarmPoints()

-- Atualizar GUI periodicamente
while guiEnabled do
    updateGUI()
    wait(0.5)
end
