local Players = game:GetService("Players")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LongLoading"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 0
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Text = "Loading..."
label.Parent = gui

local startTime = os.clock()
local duration = 60 * 60 -- 1 hour

while os.clock() - startTime < duration do
    for i = 1, 3 do
        label.Text = "Loading" .. string.rep(".", i)
        task.wait(0.5)
    end
end

label.Text = "Loading complete!"
task.wait(2)
gui:Destroy()
