--// NEON BUTTERFLY LOADING SCREEN
--// Visual-only loading effect
--// Place this LocalScript inside:
--// StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- SETTINGS
--==================================================

local TOTAL_TIME = 3 * 60 * 60 -- 3 HOURS
local BUTTERFLY_COUNT = 18

local NEON_PURPLE = Color3.fromRGB(190, 70, 255)
local NEON_BLUE = Color3.fromRGB(70, 150, 255)
local DARK = Color3.fromRGB(5, 3, 18)

--==================================================
-- SCREEN GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "NeonLoadingScreen"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Parent = playerGui

-- Background
local background = Instance.new("Frame")
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = DARK
background.BorderSizePixel = 0
background.Parent = gui

-- Gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 2, 18)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(16, 5, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 5, 25))
})
gradient.Rotation = 45
gradient.Parent = background

--==================================================
-- NEON PARTICLES
--==================================================

local particleLayer = Instance.new("Frame")
particleLayer.Size = UDim2.fromScale(1, 1)
particleLayer.BackgroundTransparency = 1
particleLayer.ClipsDescendants = true
particleLayer.Parent = background

for i = 1, 70 do
	local dot = Instance.new("Frame")

	local size = math.random(2, 6)

	dot.Size = UDim2.fromOffset(size, size)
	dot.Position = UDim2.fromScale(
		math.random(),
		math.random()
	)

	dot.BackgroundColor3 =
		(math.random(1, 2) == 1)
		and NEON_PURPLE
		or NEON_BLUE

	dot.BorderSizePixel = 0
	dot.BackgroundTransparency = math.random(2, 7) / 10
	dot.Parent = particleLayer

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = dot

	-- Glow
	local glow = Instance.new("UIStroke")
	glow.Color = dot.BackgroundColor3
	glow.Thickness = 2
	glow.Transparency = 0.5
	glow.Parent = dot

	task.spawn(function()
		while dot.Parent do
			local newX = math.random()
			local newY = math.random()

			local tween = TweenService:Create(
				dot,
				TweenInfo.new(
					math.random(3, 7),
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					Position = UDim2.fromScale(newX, newY),
					BackgroundTransparency = math.random(2, 8) / 10
				}
			)

			tween:Play()
			tween.Completed:Wait()
		end
	end)
end

--==================================================
-- BUTTERFLY CREATOR
--==================================================

local function createButterfly()

	local butterfly = Instance.new("Frame")
	butterfly.Name = "NeonButterfly"
	butterfly.Size = UDim2.fromOffset(
		math.random(25, 45),
		math.random(20, 40)
	)
	butterfly.BackgroundTransparency = 1
	butterfly.Position = UDim2.fromScale(
		math.random(),
		math.random()
	)
	butterfly.ZIndex = 5
	butterfly.Parent = particleLayer

	-- Left wing
	local leftWing = Instance.new("Frame")
	leftWing.Size = UDim2.fromScale(0.5, 0.8)
	leftWing.Position = UDim2.fromScale(0, 0.1)
	leftWing.BackgroundColor3 = NEON_PURPLE
	leftWing.BackgroundTransparency = 0.2
	leftWing.BorderSizePixel = 0
	leftWing.Rotation = -20
	leftWing.Parent = butterfly

	local leftCorner = Instance.new("UICorner")
	leftCorner.CornerRadius = UDim.new(1, 0)
	leftCorner.Parent = leftWing

	-- Right wing
	local rightWing = Instance.new("Frame")
	rightWing.Size = UDim2.fromScale(0.5, 0.8)
	rightWing.Position = UDim2.fromScale(0.5, 0.1)
	rightWing.BackgroundColor3 = NEON_BLUE
	rightWing.BackgroundTransparency = 0.2
	rightWing.BorderSizePixel = 0
	rightWing.Rotation = 20
	rightWing.Parent = butterfly

	local rightCorner = Instance.new("UICorner")
	rightCorner.CornerRadius = UDim.new(1, 0)
	rightCorner.Parent = rightWing

	-- Body
	local body = Instance.new("Frame")
	body.Size = UDim2.fromScale(0.08, 0.8)
	body.Position = UDim2.fromScale(0.46, 0.1)
	body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	body.BorderSizePixel = 0
	body.Parent = butterfly

	local bodyCorner = Instance.new("UICorner")
	bodyCorner.CornerRadius = UDim.new(1, 0)
	bodyCorner.Parent = body

	-- Neon glow
	for _, wing in ipairs({leftWing, rightWing}) do
		local stroke = Instance.new("UIStroke")
		stroke.Color = wing.BackgroundColor3
		stroke.Thickness = 2
		stroke.Transparency = 0.15
		stroke.Parent = wing
	end

	-- Flying animation
	task.spawn(function()

		while butterfly.Parent do

			local newPosition = UDim2.fromScale(
				math.random(-10, 110) / 100,
				math.random(-10, 110) / 100
			)

			local tween = TweenService:Create(
				butterfly,
				TweenInfo.new(
					math.random(5, 10),
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					Position = newPosition,
					Rotation = math.random(-25, 25)
				}
			)

			tween:Play()
			tween.Completed:Wait()
		end

	end)

	-- Wing flapping
	task.spawn(function()

		while butterfly.Parent do

			local flap1 = TweenService:Create(
				leftWing,
				TweenInfo.new(0.18, Enum.EasingStyle.Sine),
				{Rotation = -45}
			)

			local flap2 = TweenService:Create(
				rightWing,
				TweenInfo.new(0.18, Enum.EasingStyle.Sine),
				{Rotation = 45}
			)

			flap1:Play()
			flap2:Play()

			task.wait(0.18)

			local flap3 = TweenService:Create(
				leftWing,
				TweenInfo.new(0.18, Enum.EasingStyle.Sine),
				{Rotation = -15}
			)

			local flap4 = TweenService:Create(
				rightWing,
				TweenInfo.new(0.18, Enum.EasingStyle.Sine),
				{Rotation = 15}
			)

			flap3:Play()
			flap4:Play()

			task.wait(0.18)
		end

	end)
end

for i = 1, BUTTERFLY_COUNT do
	createButterfly()
end

--==================================================
-- CENTER CONTAINER
--==================================================

local main = Instance.new("Frame")
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.5)
main.Size = UDim2.fromScale(0.75, 0.55)
main.BackgroundTransparency = 1
main.ZIndex = 20
main.Parent = background

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(1, 0.2)
title.Position = UDim2.fromScale(0, 0)
title.BackgroundTransparency = 1
title.Text = "PROCESSING ANTI CHEAT"
title.TextColor3 = Color3.fromRGB(245, 220, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.ZIndex = 21
title.Parent = main

local titleStroke = Instance.new("UIStroke")
titleStroke.Color = NEON_PURPLE
titleStroke.Thickness = 2
titleStroke.Parent = title

-- Pulsing title
task.spawn(function()
	while gui.Parent do
		TweenService:Create(
			title,
			TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{TextTransparency = 0.25}
		):Play()

		task.wait(1)

		TweenService:Create(
			title,
			TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{TextTransparency = 0}
		):Play()

		task.wait(1)
	end
end)

--==================================================
-- STATUS
--==================================================

local status = Instance.new("TextLabel")
status.Size = UDim2.fromScale(1, 0.08)
status.Position = UDim2.fromScale(0, 0.21)
status.BackgroundTransparency = 1
status.Text = "PLEASE WAIT • VERIFYING GAME INTEGRITY..."
status.TextColor3 = Color3.fromRGB(190, 150, 255)
status.TextScaled = true
status.Font = Enum.Font.GothamMedium
status.ZIndex = 21
status.Parent = main

--==================================================
-- PROGRESS BAR
--==================================================

local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.fromScale(0.85, 0.055)
barBackground.Position = UDim2.fromScale(0.075, 0.35)
barBackground.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
barBackground.BorderSizePixel = 0
barBackground.ZIndex = 21
barBackground.Parent = main

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBackground

local barStroke = Instance.new("UIStroke")
barStroke.Color = NEON_PURPLE
barStroke.Thickness = 2
barStroke.Parent = barBackground

local bar = Instance.new("Frame")
bar.Size = UDim2.fromScale(0, 1)
bar.BackgroundColor3 = NEON_PURPLE
bar.BorderSizePixel = 0
bar.ZIndex = 22
bar.Parent = barBackground

local barCorner2 = Instance.new("UICorner")
barCorner2.CornerRadius = UDim.new(1, 0)
barCorner2.Parent = bar

local barGradient = Instance.new("UIGradient")
barGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, NEON_BLUE),
	ColorSequenceKeypoint.new(0.5, NEON_PURPLE),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 220))
})
barGradient.Parent = bar

--==================================================
-- PERCENTAGE
--==================================================

local percent = Instance.new("TextLabel")
percent.Size = UDim2.fromScale(1, 0.07)
percent.Position = UDim2.fromScale(0, 0.42)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.TextColor3 = Color3.fromRGB(220, 190, 255)
percent.TextScaled = true
percent.Font = Enum.Font.GothamBold
percent.ZIndex = 21
percent.Parent = main

--==================================================
-- TIMER
--==================================================

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.fromScale(1, 0.13)
timerLabel.Position = UDim2.fromScale(0, 0.50)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "03:00:00"
timerLabel.TextColor3 = Color3.fromRGB(240, 180, 255)
timerLabel.TextScaled = true
timerLabel.Font = Enum.Font.GothamBlack
timerLabel.ZIndex = 21
timerLabel.Parent = main

local timerStroke = Instance.new("UIStroke")
timerStroke.Color = NEON_PURPLE
timerStroke.Thickness = 2
timerStroke.Parent = timerLabel

local timerInfo = Instance.new("TextLabel")
timerInfo.Size = UDim2.fromScale(1, 0.06)
timerInfo.Position = UDim2.fromScale(0, 0.63)
timerInfo.BackgroundTransparency = 1
timerInfo.Text = "ESTIMATED PROCESSING TIME • 3 HOURS"
timerInfo.TextColor3 = Color3.fromRGB(160, 130, 200)
timerInfo.TextScaled = true
timerInfo.Font = Enum.Font.Gotham
timerInfo.ZIndex = 21
timerInfo.Parent = main

--==================================================
-- MAIN ACCOUNT REMINDER
--==================================================

local reminder = Instance.new("TextLabel")
reminder.Size = UDim2.fromScale(0.9, 0.12)
reminder.Position = UDim2.fromScale(0.05, 0.74)
reminder.BackgroundTransparency = 1
reminder.Text =
	"⚠  REMEMBER TO USE YOUR MAIN ACCOUNT  ⚠\nFor the intended game experience, please use your main account."
reminder.TextColor3 = Color3.fromRGB(255, 210, 255)
reminder.TextScaled = true
reminder.Font = Enum.Font.GothamBold
reminder.ZIndex = 21
reminder.Parent = main

local reminderStroke = Instance.new("UIStroke")
reminderStroke.Color = NEON_PURPLE
reminderStroke.Thickness = 1.5
reminderStroke.Parent = reminder

--==================================================
-- ANIMATED REMINDER
--==================================================

task.spawn(function()
	while gui.Parent do

		TweenService:Create(
			reminder,
			TweenInfo.new(0.8, Enum.EasingStyle.Sine),
			{TextTransparency = 0.35}
		):Play()

		task.wait(0.8)

		TweenService:Create(
			reminder,
			TweenInfo.new(0.8, Enum.EasingStyle.Sine),
			{TextTransparency = 0}
		):Play()

		task.wait(0.8)
	end
end)

--==================================================
-- LOADING DOTS
--==================================================

local dots = Instance.new("TextLabel")
dots.Size = UDim2.fromScale(1, 0.06)
dots.Position = UDim2.fromScale(0, 0.91)
dots.BackgroundTransparency = 1
dots.Text = "LOADING"
dots.TextColor3 = NEON_BLUE
dots.TextScaled = true
dots.Font = Enum.Font.GothamBold
dots.ZIndex = 21
dots.Parent = main

task.spawn(function()

	local count = 0

	while gui.Parent do

		count += 1
		if count > 3 then
			count = 0
		end

		dots.Text = "LOADING" .. string.rep(".", count)

		task.wait(0.5)
	end

end)

--==================================================
-- TIMER + PROGRESS
--==================================================

local startTime = os.clock()

RunService.RenderStepped:Connect(function()

	if not gui.Parent then
		return
	end

	local elapsed = os.clock() - startTime
	local remaining = math.max(TOTAL_TIME - elapsed, 0)

	-- Progress
	local progress = math.clamp(elapsed / TOTAL_TIME, 0, 1)

	bar.Size = UDim2.fromScale(progress, 1)
	percent.Text = math.floor(progress * 100) .. "%"

	-- Time
	local hours = math.floor(remaining / 3600)
	local minutes = math.floor((remaining % 3600) / 60)
	local seconds = math.floor(remaining % 60)

	timerLabel.Text = string.format(
		"%02d:%02d:%02d",
		hours,
		minutes,
		seconds
	)

	-- Finish
	if remaining <= 0 then
		timerLabel.Text = "COMPLETE"
		percent.Text = "100%"
		status.Text = "PROCESSING COMPLETE • WELCOME"

		task.wait(2)

		-- Fade out
		for _, object in ipairs(gui:GetDescendants()) do
			if object:IsA("TextLabel") then
				TweenService:Create(
					object,
					TweenInfo.new(1),
					{TextTransparency = 1}
				):Play()
			elseif object:IsA("Frame") then
				TweenService:Create(
					object,
					TweenInfo.new(1),
					{BackgroundTransparency = 1}
				):Play()
			end
		end

		task.wait(1.2)
		gui:Destroy()
	end
end)
