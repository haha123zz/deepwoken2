local players = game:GetService("Players")
local client = players.LocalPlayer
local character = client or client.CharacterAdded:Wait()

local function checkMob(model)
    if (model:FindFirstChildOfClass("Humanoid")) then
        if (not players:GetPlayerFromCharacter(model)) then
            return true 
        end
    end    
end

local function getMobs()
    local live = workspace:WaitForChild("Live")
    local mobs = {}

    for _, mob in ipairs(live:GetChildren()) do
        if (checkMob(mob)) then
            table.insert(mobs, mob)
        end
    end

    return mobs 
end


print(unpack(getMobs()))