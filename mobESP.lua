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
            if mob.Parent ~= nil and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChild("HumanoidRootPart", true) then
                local vector, onScren = workspace.CurrentCamera:WorldToViewportPoint(mob:FindFirstChild("HumanoidRootPart", true).Position)

                local rootPart = mob:FindFirstChild("HumanoidRootPart", true)
                local head = mob:FindFirstChild("Head", true)
                local headPosition = workspace.CurrentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local LegPosition = workspace.CurrentCamera:WorldToViewportPoint(rootPart - Vector3.new(0,3,0))

                BoxOutline.Size = Vector2.new(1000/ vector.Z, headPosition.Y - LegPosition.Y)
                BoxOutline.Position = Vector2.new(vector.X - BoxOutline.Size.X / 2, vector.Y - BoxOutline.Size.Y / 2)
                BoxOutline.Visible = true 

                Box.Size = Vector2.new(1000 / vector.Z, headPosition.Y - LegPosition)
                Box.Position = Vector2.new(vector.X - Box.Size.X/  2, vector.Y - Box.Size.Y / 2)
                Box.Visible = true 

                HealthBarOutline.Size = Vector2.new(2, headPosition.Y - LegPosition.Y)
                HealthBarOutline.Posiiton = BoxOutline.Position - Vector2.new(6, 0)
                HealthBarOutline.Visible = true 

                HealthBar.Size = Vector2.new(2, (headPosition.Y - LegPosition.Y) / (mob:FindFirstChildOfClass("Humanoid").MaxHealth / math.clamp(mob:FindFirstChildOfClass("Humanoid").Health, 0, mob:FindFirstChildOfClass("Humanoid").MaxHealth)))
                HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
                HealthBar.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            else
                HealthBar.Visible = false 
                Box.Visible = false 
                HealthBarOutline.Visible = false 
                BoxOutline.Visible = false
            end
        end)

        if (mob:FindFirstChildOfClass("Humanoid")) then
            mob:FindFirstChildOfClass("Humanoid").Died:Connect(function()
                HealthBar.Visible = false 
                Box.Visible = false 
                HealthBarOutline.Visible = false 
                BoxOutline.Visible = false
                connection:Disconnect()
            end)
        end
    end

    boxesp()
end