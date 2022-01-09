local players = game:GetService("Players")
local client = players.LocalPlayer
local character = client or client.CharacterAdded:Wait()
local live = workspace:WaitForChild("Live")

local function checkMob(model)
    if (model:FindFirstChildOfClass("Humanoid")) then
        if (not players:GetPlayerFromCharacter(model)) then
            return true 
        end
    end    
end

local function getMobs()
    local mobs = {}

    for _, mob in ipairs(live:GetChildren()) do
        if (checkMob(mob)) then
            table.insert(mobs, mob)
        end
    end

    return mobs 
end

for _, mob in ipairs(getMobs()) do
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false 
    BoxOutline.Color = Color3.new(0,0,0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.new(1,1,1)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local HealthBarOutline = Drawing.new("Square")
    HealthBarOutline.Thickness = 3
    HealthBarOutline.Filled = false
    HealthBarOutline.Color = Color3.new(0,0,0)
    HealthBarOutline.Transparency = 1
    HealthBarOutline.Visible = false

    local HealthBar = Drawing.new("Square")
    HealthBar.Thickness = 1
    HealthBar.Filled = false
    HealthBar.Transparency = 1
    HealthBar.Visible = false

    local function boxesp()
        local connection 
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if mob.Parent ~= nil and mob:FindFirstChildOfClass("Humanoid") then
                local vector, onScren = workspace.CurrentCamera:WorldToViewportPoint
            end
        end)

        if (mob:FindFirstChildOfClass("Humanoid")) then
            mob:FindFirstChildOfClass("Humanoid").Died:Connect(function()
                connection:Disconnect()
            end)
        end
    end
end