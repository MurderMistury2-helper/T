--// NEON ANIME LOADING SCREEN
--// VISUAL ONLY — no real anti-cheat or account scanning
--// Place this LocalScript inside StarterGui > ScreenGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = script.Parent

gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local PROCESS_TIME = 3 * 60 * 60 -- 3 HOURS
local IMAGE_ID = "rbxassetid://YOUR_IMAGE_ASSET_ID"

--------------------------------------------------
-- MAIN SCREEN
--------------------------------------------------

local screen = Instance.new("Frame")
screen.Size = UDim2.fromScale(1, 1)
screen.BackgroundColor3 = Color3.fromRGB(7, 3, 20)
screen.BorderSizePixel = 0
screen.Parent = gui

--------------------------------------------------
-- BACKGROUND IMAGE
--------------------------------------------------

local background = Instance.new("ImageLabel")
background.Size = UDim2.fromScale(1, 1)
background.BackgroundTransparency = 1
background.Image = IMAGE_ID
background.ScaleType = Enum.ScaleType.Crop
background.ImageTransparency = 0.05
background.Parent = screen

--------------------------------------------------
-- DARK OVERLAY
--------------------------------------------------

local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.fromRGB(5, 0, 15)
overlay.BackgroundTransparency = 0.38
overlay.BorderSizePixel = 0
overlay.Parent = screen

--------------------------------------------------
-- TITLE
--------------------------------------------------

local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(0.5, 0)
title.Position = UDim2.fromScale(0.70, 0.075)
title.Size = UDim2.fromScale(0.48, 0.10)
title.BackgroundTransparency = 1
title.Text = "PROCESSING"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 100, 255)
title.TextStrokeTransparency = 0.25
title.TextStrokeColor3 = Color3.fromRGB(130, 0, 255)
title.Parent = screen

--------------------------------------------------
-- SUBTITLE
--------------------------------------------------

local subtitle = Instance.new("TextLabel")
subtitle.AnchorPoint = Vector2.new(0.5, 0)
subtitle.Position = UDim2.fromScale(0.70, 0.175)
subtitle.Size = UDim2.fromScale(0.43, 0.07)
subtitle.BackgroundTransparency = 1
subtitle.Text = "ANTI-CHEAT"
subtitle.Font = Enum.Font.GothamBlack
subtitle.TextScaled = true
subtitle.TextColor3 = Color3.fromRGB(230, 245, 255)
subtitle.TextStrokeTransparency = 0.35
subtitle.Parent = screen

--------------------------------------------------
-- STATUS
--------------------------------------------------

local status = Instance.new("TextLabel")
status.AnchorPoint = Vector2.new(0.5, 0)
status.Position = UDim2.fromScale(0.70, 0.25)
status.Size = UDim2.fromScale(0.45, 0.045)
status.BackgroundTransparency = 1
status.Text = "SECURITY VERIFICATION IN PROGRESS..."
status.Font = Enum.Font.GothamBold
status.TextScaled = true
status.TextColor3 = Color3.fromRGB(190, 180, 255)
status.Parent = screen

--------------------------------------------------
-- PROGRESS CIRCLE
--------------------------------------------------

local circle = Instance.new("Frame")
circle.AnchorPoint = Vector2.new(0.5, 0.5)
circle.Position = UDim2.fromScale(0.60, 0.57)
circle.Size = UDim2.fromScale(0.22, 0.22)
circle.BackgroundColor3 = Color3.fromRGB(12, 5, 35)
circle.BorderSizePixel = 0
circle.Parent = screen

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circle

local circleStroke = Instance.new("UIStroke")
circleStroke.Thickness = 5
circleStroke.Color = Color3.fromRGB(210, 50, 255)
circleStroke.Transparency = 0.15
circleStroke.Parent = circle

--------------------------------------------------
-- PERCENTAGE
--------------------------------------------------

local percent = Instance.new("TextLabel")
percent.AnchorPoint = Vector2.new(0.5, 0.5)
percent.Position = UDim2.fromScale(0.5, 0.5)
percent.Size = UDim2.fromScale(0.75, 0.35)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.Font = Enum.Font.GothamBlack
percent.TextScaled = true
percent.TextColor3 = Color3.fromRGB(245, 240, 255)
percent.Parent = circle

--------------------------------------------------
-- MOVING NEON RING
--------------------------------------------------

local ring = Instance.new("UIStroke")
ring.Thickness = 8
ring.Color = Color3.fromRGB(70, 220, 255)
ring.Parent = circle

task.spawn(function()
	while screen.Parent do
		local t = TweenService:Create(
			ring,
			TweenInfo.new(
				1.2,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut,
				-1,
				true
			),
			{
				Transparency = 0.65,
				Thickness = 13
			}
		)

		t:Play()
		t.Completed:Wait()
	end
end)

--------------------------------------------------
-- PROGRESS BAR
--------------------------------------------------

local barBack = Instance.new("Frame")
barBack.AnchorPoint = Vector2.new(0.5, 0)
barBack.Position = UDim2.fromScale(0.70, 0.70)
barBack.Size = UDim2.fromScale(0.42, 0.035)
barBack.BackgroundColor3 = Color3.fromRGB(22, 10, 50)
barBack.BorderSizePixel = 0
barBack.ClipsDescendants = true
barBack.Parent = screen

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBack

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(190, 50, 255)
bar.BorderSizePixel = 0
bar.Parent = barBack

local barCorner2 = Instance.new("UICorner")
barCorner2.CornerRadius = UDim.new(1, 0)
barCorner2.Parent = bar

--------------------------------------------------
-- MOVING BAR GLOW
--------------------------------------------------

local shine = Instance.new("Frame")
shine.Size = UDim2.fromScale(0.12, 1)
shine.Position = UDim2.fromScale(-0.15, 0)
shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shine.BackgroundTransparency = 0.35
shine.BorderSizePixel = 0
shine.Parent = barBack

local shineCorner = Instance.new("UICorner")
shineCorner.CornerRadius = UDim.new(1, 0)
shineCorner.Parent = shine

task.spawn(function()
	while screen.Parent do
		shine.Position = UDim2.fromScale(-0.15, 0)

		local tween = TweenService:Create(
			shine,
			TweenInfo.new(1.3, Enum.EasingStyle.Linear),
			{Position = UDim2.fromScale(1.05, 0)}
		)

		tween:Play()
		tween.Completed:Wait()
	end
end)

--------------------------------------------------
-- LOADING TEXT
--------------------------------------------------

local loading = Instance.new("TextLabel")
loading.AnchorPoint = Vector2.new(0.5, 0)
loading.Position = UDim2.fromScale(0.70, 0.745)
loading.Size = UDim2.fromScale(0.40, 0.045)
loading.BackgroundTransparency = 1
loading.Text = "LOADING... PLEASE WAIT"
loading.Font = Enum.Font.GothamBold
loading.TextScaled = true
loading.TextColor3 = Color3.fromRGB(230, 210, 255)
loading.Parent = screen

--------------------------------------------------
-- REMEMBER MESSAGE
--------------------------------------------------

local remember = Instance.new("TextLabel")
remember.AnchorPoint = Vector2.new(0.5, 0)
remember.Position = UDim2.fromScale(0.70, 0.82)
remember.Size = UDim2.fromScale(0.52, 0.075)
remember.BackgroundTransparency = 1
remember.Text = "👑  REMEMBER:\nUSE YOUR MAIN ACCOUNT ♥"
remember.Font = Enum.Font.GothamBlack
remember.TextScaled = true
remember.TextColor3 = Color3.fromRGB(255, 170, 255)
remember.TextStrokeTransparency = 0.35
remember.Parent = screen

--------------------------------------------------
-- SCANNING SYSTEMS PANEL
--------------------------------------------------

local panel = Instance.new("Frame")
panel.AnchorPoint = Vector2.new(1, 0)
panel.Position = UDim2.fromScale(0.97, 0.55)
panel.Size = UDim2.fromScale(0.25, 0.25)
panel.BackgroundColor3 = Color3.fromRGB(13, 5, 32)
panel.BackgroundTransparency = 0.15
panel.BorderSizePixel = 0
panel.Parent = screen

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 14)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Thickness = 3
panelStroke.Color = Color3.fromRGB(100, 50, 255)
panelStroke.Parent = panel

local panelTitle = Instance.new("TextLabel")
panelTitle.Position = UDim2.fromScale(0.06, 0.06)
panelTitle.Size = UDim2.fromScale(0.88, 0.13)
panelTitle.BackgroundTransparency = 1
panelTitle.Text = "SCANNING SYSTEMS"
panelTitle.Font = Enum.Font.GothamBlack
panelTitle.TextScaled = true
panelTitle.TextColor3 = Color3.fromRGB(100, 230, 255)
panelTitle.Parent = panel

local systems = {
	"● Account Integrity",
	"● Game Files",
	"● Client Security",
	"● Exploit Detection",
	"● Behavior Analysis",
	"● Environment Check"
}

for i, text in ipairs(systems) do
	local item = Instance.new("TextLabel")
	item.Position = UDim2.fromScale(0.08, 0.19 + ((i - 1) * 0.125))
	item.Size = UDim2.fromScale(0.84, 0.10)
	item.BackgroundTransparency = 1
	item.Text = text
	item.Font = Enum.Font.GothamMedium
	item.TextScaled = true
	item.TextXAlignment = Enum.TextXAlignment.Left
	item.TextColor3 = Color3.fromRGB(220, 210, 240)
	item.Parent = panel

	-- Each system gets its own pulsing animation
	task.spawn(function()
		while item.Parent do
			TweenService:Create(
				item,
				TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
				{TextTransparency = 0.45}
			):Play()

			task.wait(0.7)

			TweenService:Create(
				item,
				TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
				{TextTransparency = 0}
			):Play()

			task.wait(0.7)
		end
	end)
end

--------------------------------------------------
-- ANIMATED BUTTERFLIES / PARTICLES
--------------------------------------------------

local function createButterfly()
	local butterfly = Instance.new("TextLabel")
	butterfly.Size = UDim2.fromScale(0.035, 0.06)
	butterfly.BackgroundTransparency = 1
	butterfly.Text = "🦋"
	butterfly.TextScaled = true
	butterfly.TextTransparency = 0.1

	butterfly.Position = UDim2.fromScale(
		math.random(5, 95) / 100,
		math.random(10, 90) / 100
	)

	butterfly.Parent = screen

	local targetX = math.clamp(
		butterfly.Position.X.Scale + math.random(-15, 15) / 100,
		0.02,
		0.98
	)

	local targetY = math.clamp(
		butterfly.Position.Y.Scale + math.random(-12, 12) / 100,
		0.05,
		0.95
	)

	local tween = TweenService:Create(
		butterfly,
		TweenInfo.new(
			math.random(25, 45) / 10,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.InOut
		),
		{
			Position = UDim2.fromScale(targetX, targetY),
			Rotation = math.random(-20, 20)
		}
	)

	tween:Play()

	task.spawn(function()
		while butterfly.Parent do
			TweenService:Create(
				butterfly,
				TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
				{TextTransparency = 0.6}
			):Play()

			task.wait(0.8)

			TweenService:Create(
				butterfly,
				TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
				{TextTransparency = 0.1}
			):Play()

			task.wait(0.8)
		end
	end

	task.delay(5, function()
		if butterfly then
			butterfly:Destroy()
		end
	end)
end

task.spawn(function()
	while screen.Parent do
		createButterfly()
		task.wait(0.7)
	end
end)

--------------------------------------------------
-- ANIMATED STATUS DOTS
--------------------------------------------------

task.spawn(function()
	local dots = 0

	while screen.Parent do
		dots = (dots + 1) % 4
		status.Text = "SECURITY VERIFICATION IN PROGRESS" .. string.rep(".", dots)

		task.wait(0.5)
	end
end)

--------------------------------------------------
-- 3-HOUR VISUAL PROCESS
--------------------------------------------------

local startTime = os.clock()

task.spawn(function()
	while screen.Parent do

		local elapsed = os.clock() - startTime

		local progress = math.clamp(
			elapsed / PROCESS_TIME,
			0,
			1
		)

		-- Slowly increases from 0% to 100% over 3 hours
		percent.Text = math.floor(progress * 100) .. "%"

		TweenService:Create(
			bar,
			TweenInfo.new(1, Enum.EasingStyle.Linear),
			{
				Size = UDim2.new(progress, 0, 1, 0)
			}
		):Play()

		if progress >= 1 then
			status.Text = "SECURITY VERIFICATION COMPLETE"
			loading.Text = "PROCESS COMPLETE ♥"
			break
		end

		task.wait(1)
	end
end)

--------------------------------------------------
-- TITLE PULSE
--------------------------------------------------

task.spawn(function()
	while screen.Parent do

		TweenService:Create(
			title,
			TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				TextTransparency = 0.25,
				TextStrokeTransparency = 0
			}
		):Play()

		task.wait(1.2)

		TweenService:Create(
			title,
			TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				TextTransparency = 0,
				TextStrokeTransparency = 0.25
			}
		):Play()

		task.wait(1.2)
	end
end)

--------------------------------------------------
-- REMEMBER MESSAGE PULSE
--------------------------------------------------

task.spawn(function()
	while screen.Parent do

		TweenService:Create(
			remember,
			TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				TextSize = 30
			}
		):Play()

		task.wait(0.9)

		TweenService:Create(
			remember,
			TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{
				TextSize = 26
			}
		):Play()

		task.wait(0.9)
	end
end)
