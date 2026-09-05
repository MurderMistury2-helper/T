local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreenGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndex = 999
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Background with gradient effect
local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
background.BorderSizePixel = 0
background.ZIndex = 1
background.Parent = screenGui

-- Animated gradient overlay
local gradientOverlay = Instance.new("Frame")
gradientOverlay.Name = "GradientOverlay"
gradientOverlay.Size = UDim2.new(1, 0, 1, 0)
gradientOverlay.Position = UDim2.new(0, 0, 0, 0)
gradientOverlay.BackgroundColor3 = Color3.fromRGB(25, 10, 50)
gradientOverlay.BackgroundTransparency = 0.3
gradientOverlay.BorderSizePixel = 0
gradientOverlay.ZIndex = 2
gradientOverlay.Parent = background

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 40)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 20, 80)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 40))
})
uiGradient.Parent = gradientOverlay

-- Animated particle effect container
local particleContainer = Instance.new("Frame")
particleContainer.Name = "ParticleContainer"
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.Position = UDim2.new(0, 0, 0, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.BorderSizePixel = 0
particleContainer.ZIndex = 3
particleContainer.Parent = background

-- Function to create floating particles
local function createParticle()
	local particle = Instance.new("Frame")
	particle.Size = UDim2.new(0, math.random(2, 8), 0, math.random(2, 8))
	particle.Position = UDim2.new(math.random(0, 100)/100, 0, math.random(0, 100)/100, 0)
	particle.BackgroundColor3 = Color3.fromRGB(math.random(100, 255), math.random(50, 150), math.random(150, 255))
	particle.BackgroundTransparency = 0.7
	particle.BorderSizePixel = 0
	particle.ZIndex = 4
	particle.Parent = particleContainer
	
	-- Add corner radius
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = particle
	
	-- Animate particle
	local startX = particle.Position.X.Scale
	local startY = particle.Position.Y.Scale
	
	spawn(function()
		for i = 1, 100 do
			particle.Position = UDim2.new(startX + math.sin(i/10) * 0.1, 0, startY - i/100, 0)
			particle.BackgroundTransparency = 0.7 + (i/100) * 0.3
			wait(0.03)
		end
		particle:Destroy()
	end)
end

-- Spawn particles periodically
spawn(function()
	while true do
		createParticle()
		wait(0.2)
	end
end)

-- Main loading container
local loadingContainer = Instance.new("Frame")
loadingContainer.Name = "LoadingContainer"
loadingContainer.Size = UDim2.new(0.6, 0, 0.7, 0)
loadingContainer.Position = UDim2.new(0.2, 0, 0.15, 0)
loadingContainer.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
loadingContainer.BackgroundTransparency = 0.1
loadingContainer.BorderSizePixel = 2
loadingContainer.BorderColor3 = Color3.fromRGB(150, 50, 200)
loadingContainer.ZIndex = 10
loadingContainer.Parent = screenGui

-- Add glow effect to container
local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 20)
containerCorner.Parent = loadingContainer

-- Anime girl image area (placeholder text - replace with actual image asset)
local girlContainer = Instance.new("Frame")
girlContainer.Name = "GirlContainer"
girlContainer.Size = UDim2.new(0.4, 0, 0.8, 0)
girlContainer.Position = UDim2.new(0.05, 0, 0.1, 0)
girlContainer.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
girlContainer.BackgroundTransparency = 0.3
girlContainer.BorderSizePixel = 1
girlContainer.BorderColor3 = Color3.fromRGB(200, 100, 255)
girlContainer.ZIndex = 11
girlContainer.Parent = loadingContainer

local girlCorner = Instance.new("UICorner")
girlCorner.CornerRadius = UDim.new(0, 15)
girlCorner.Parent = girlContainer

-- Anime girl image (use your own image asset ID)
local girlImage = Instance.new("ImageLabel")
girlImage.Name = "GirlImage"
girlImage.Size = UDim2.new(1, 0, 1, 0)
girlImage.Position = UDim2.new(0, 0, 0, 0)
girlImage.BackgroundTransparency = 1
girlImage.Image = "rbxasset://textures/face.png" -- Replace with your anime girl image ID
girlImage.ZIndex = 12
girlImage.Parent = girlContainer

-- Animate girl with bouncing and rotating effect
spawn(function()
	local time = 0
	while true do
		time = time + 0.02
		local bounce = math.sin(time * 2) * 10
		local scale = 1 + math.sin(time) * 0.05
		
		girlContainer.Position = UDim2.new(0.05, 0, 0.1 + bounce/200, 0)
		girlImage.Size = UDim2.new(scale, 0, scale, 0)
		girlImage.Position = UDim2.new((1-scale)/2, 0, (1-scale)/2, 0)
		
		-- Add rotation effect
		if not girlImage:FindFirstChild("UIAspectRatioConstraint") then
			local aspect = Instance.new("UIAspectRatioConstraint")
			aspect.AspectRatio = 1
			aspect.Parent = girlImage
		end
		
		wait(0.03)
	end
end)

-- Right side content container
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(0.55, 0, 0.8, 0)
contentContainer.Position = UDim2.new(0.45, 0, 0.1, 0)
contentContainer.BackgroundTransparency = 1
contentContainer.BorderSizePixel = 0
contentContainer.ZIndex = 11
contentContainer.Parent = loadingContainer

-- Title text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, 0, 0.15, 0)
titleText.Position = UDim2.new(0, 0, 0.05, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🎮 LOADING GAME"
titleText.TextColor3 = Color3.fromRGB(200, 100, 255)
titleText.TextSize = 28
titleText.Font = Enum.Font.GothamBold
titleText.ZIndex = 12
titleText.Parent = contentContainer

-- Animated pulse effect on title
spawn(function()
	while true do
		for i = 1, 20 do
			titleText.TextColor3 = Color3.fromRGB(
				150 + math.sin(i/10) * 50,
				50 + math.sin(i/10) * 50,
				255
			)
			wait(0.05)
		end
	end
end)

-- Processing text
local processingText = Instance.new("TextLabel")
processingText.Name = "ProcessingText"
processingText.Size = UDim2.new(1, 0, 0.2, 0)
processingText.Position = UDim2.new(0, 0, 0.25, 0)
processingText.BackgroundTransparency = 1
processingText.Text = "Processing Anti Cheat..."
processingText.TextColor3 = Color3.fromRGB(150, 200, 255)
processingText.TextSize = 20
processingText.Font = Enum.Font.Gotham
processingText.ZIndex = 12
processingText.Parent = contentContainer

-- Animated loading indicator
spawn(function()
	local dots = 0
	while true do
		dots = (dots + 1) % 4
		processingText.Text = "Processing Anti Cheat" .. string.rep(".", dots)
		wait(0.5)
	end
end)

-- Progress bar background
local progressBarBg = Instance.new("Frame")
progressBarBg.Name = "ProgressBarBg"
progressBarBg.Size = UDim2.new(0.9, 0, 0.08, 0)
progressBarBg.Position = UDim2.new(0.05, 0, 0.5, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
progressBarBg.BorderSizePixel = 1
progressBarBg.BorderColor3 = Color3.fromRGB(150, 50, 200)
progressBarBg.ZIndex = 12
progressBarBg.Parent = contentContainer

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 10)
progressCorner.Parent = progressBarBg

-- Animated progress bar
local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.Position = UDim2.new(0, 0, 0, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 13
progressBar.Parent = progressBarBg

local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0, 10)
innerCorner.Parent = progressBar

-- Glow effect on progress bar
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 0, 1, 0)
glow.Position = UDim2.new(0, 0, 0, 0)
glow.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
glow.BackgroundTransparency = 0.5
glow.BorderSizePixel = 0
glow.ZIndex = 12
glow.Parent = progressBar

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 10)
glowCorner.Parent = glow

-- Percentage text
local percentText = Instance.new("TextLabel")
percentText.Name = "PercentText"
percentText.Size = UDim2.new(1, 0, 1, 0)
percentText.Position = UDim2.new(0, 0, 0, 0)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = Color3.fromRGB(255, 255, 255)
percentText.TextSize = 16
percentText.Font = Enum.Font.GothamBold
percentText.ZIndex = 14
percentText.Parent = progressBarBg

-- Time text
local timeText = Instance.new("TextLabel")
timeText.Name = "TimeText"
timeText.Size = UDim2.new(1, 0, 0.1, 0)
timeText.Position = UDim2.new(0, 0, 0.62, 0)
timeText.BackgroundTransparency = 1
timeText.Text = "Estimated Time: 2:00:00"
timeText.TextColor3 = Color3.fromRGB(100, 200, 255)
timeText.TextSize = 16
timeText.Font = Enum.Font.Gotham
timeText.ZIndex = 12
timeText.Parent = contentContainer

-- Remember account text (bottom)
local rememberText = Instance.new("TextLabel")
rememberText.Name = "RememberText"
rememberText.Size = UDim2.new(1, 0, 0.2, 0)
rememberText.Position = UDim2.new(0, 0, 0.75, 0)
rememberText.BackgroundTransparency = 1
rememberText.Text = "⚠️ Remember to use your main account!"
rememberText.TextColor3 = Color3.fromRGB(255, 150, 50)
rememberText.TextSize = 16
rememberText.Font = Enum.Font.GothamBold
rememberText.TextWrapped = true
rememberText.ZIndex = 12
rememberText.Parent = contentContainer

-- Animated pulse effect on remember text
spawn(function()
	while true do
		for i = 1, 20 do
			rememberText.TextColor3 = Color3.fromRGB(
				255,
				150 + math.sin(i/10) * 50,
				50
			)
			wait(0.05)
		end
	end
end)

-- Main loading animation logic
local totalTime = 2 * 60 * 60 -- 2 hours in seconds
local elapsedTime = 0
local startTime = tick()

spawn(function()
	while elapsedTime < totalTime do
		elapsedTime = tick() - startTime
		local progress = math.min(elapsedTime / totalTime, 1)
		
		-- Update progress bar
		progressBar.Size = UDim2.new(progress, 0, 1, 0)
		
		-- Update percentage
		percentText.Text = string.format("%.1f%%", progress * 100)
		
		-- Calculate remaining time
		local remainingTime = totalTime - elapsedTime
		local hours = math.floor(remainingTime / 3600)
		local minutes = math.floor((remainingTime % 3600) / 60)
		local seconds = math.floor(remainingTime % 60)
		
		timeText.Text = string.format("Estimated Time: %02d:%02d:%02d", hours, minutes, seconds)
		
		-- Add glow pulse effect
		glow.BackgroundTransparency = 0.5 + math.sin(elapsedTime * 2) * 0.2
		
		wait(0.1)
	end
	
	-- Loading complete
	titleText.Text = "✅ LOADING COMPLETE"
	processingText.Text = "Anti Cheat Verified!"
	percentText.Text = "100%"
	timeText.Text = "Estimated Time: 00:00:00"
	
	-- Fade out effect
	wait(2)
	for i = 1, 20 do
		screenGui.BackgroundTransparency = i / 20
		wait(0.1)
	end
	
	screenGui:Destroy()
end)

-- Optional: Allow skipping loading with a key press
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.Escape then
		screenGui:Destroy()
	end
end)
