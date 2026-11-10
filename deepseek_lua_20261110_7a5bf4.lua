--[[══════════════════════════════════════════════════════════════════════════
      LIFE TOGETHER RP · AUTH0R ULTIMATE TROLLER (V21)
      ══════════════════════════════════════════════════════════════════════════
      ✅ Real In-Game Campfire (Bonfire Follower)
      ✅ Text Spawner (Items & In-Game Campfire)
      ✅ Target Features (Trap, Void, Fling, Size Lagger, Car Drop)
      ✅ Self Features (Follower, Wings)
      ✅ No Glitch (pcall + proper delay)
══════════════════════════════════════════════════════════════════════════]]
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(0.1)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

local selectedPlayer = nil
local net = nil
local allItems = {}
local campfireItem = nil
local isTrapping = false
local trapThread = nil
local lastPos = nil
local activeThreads = {}
local spawnedFireParts = {}
local textParts = {}

-- ═══════════════ NET MODULE & ASSET LOADER ═══════════════
task.spawn(function()
    pcall(function()
        local M = ReplicatedStorage:WaitForChild("Modules", 10)
        local C = M:WaitForChild("Core", 10)
        net = require(C:WaitForChild("Net", 10))
    end)

    local Pl = ReplicatedStorage:FindFirstChild("LargePlaceables")
    if Pl then
        for _, item in ipairs(Pl:GetChildren()) do
            if item:IsA("Model") then
                table.insert(allItems, item)
                -- Dhoondho game ka asli Campfire / FirePit
                if item.Name:lower():find("fire") or item.Name:lower():find("camp") or item.Name:lower():find("pit") then
                    campfireItem = item
                end
            end
        end
    end
    
    if not campfireItem then
        print("[AUTH0R WARNING] In-game Campfire not found! Using Neon fallback.")
    else
        print("[AUTH0R] Found In-Game Campfire: " .. campfireItem.Name)
    end
end)

-- ═══════════════ HELPERS ═══════════════
local function getDesc(player)
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return hum and hum:GetAppliedDescription()
end

local function buildOutfit(desc, scale)
    if not desc then return nil end
    return {
        accessories = {},
        properties = {
            HeightScale = scale, WidthScale = scale, DepthScale = scale, HeadScale = math.min(scale, 50),
            Shirt = desc.Shirt, Pants = desc.Pants, Face = desc.Face,
        }
    }
end

local function TakeOwnership(hrp)
    if hrp then pcall(function() hrp:SetNetworkOwner(lp) end) end
end

-- ═══════════════ ALPHABET SYSTEM ═══════════════
local Alphabet = {
    ["A"] = {"01110", "10001", "11111", "10001", "10001"},
    ["B"] = {"11110", "10001", "11110", "10001", "11110"},
    ["C"] = {"01111", "10000", "10000", "10000", "01111"},
    ["D"] = {"11110", "10001", "10001", "10001", "11110"},
    ["E"] = {"11111", "10000", "11110", "10000", "11111"},
    ["F"] = {"11111", "10000", "11110", "10000", "10000"},
    ["G"] = {"01111", "10000", "10011", "10001", "01111"},
    ["H"] = {"10001", "10001", "11111", "10001", "10001"},
    ["I"] = {"11111", "00100", "00100", "00100", "11111"},
    ["J"] = {"00111", "00010", "00010", "10010", "01100"},
    ["K"] = {"10001", "10010", "11100", "10010", "10001"},
    ["L"] = {"10000", "10000", "10000", "10000", "11111"},
    ["M"] = {"10001", "11011", "10101", "10001", "10001"},
    ["N"] = {"10001", "11001", "10101", "10011", "10001"},
    ["O"] = {"01110", "10001", "10001", "10001", "01110"},
    ["P"] = {"11110", "10001", "11110", "10000", "10000"},
    ["Q"] = {"01110", "10001", "10101", "10010", "01101"},
    ["R"] = {"11110", "10001", "11110", "10010", "10001"},
    ["S"] = {"01111", "10000", "01110", "00001", "11110"},
    ["T"] = {"11111", "00100", "00100", "00100", "00100"},
    ["U"] = {"10001", "10001", "10001", "10001", "01110"},
    ["V"] = {"10001", "10001", "10001", "01010", "00100"},
    ["W"] = {"10001", "10001", "10101", "11011", "10001"},
    ["X"] = {"10001", "01010", "00100", "01010", "10001"},
    ["Y"] = {"10001", "01010", "00100", "00100", "00100"},
    ["Z"] = {"11111", "00010", "00100", "01000", "11111"},
    [" "] = {"00000", "00000", "00000", "00000", "00000"}
}

-- ═══════════════ CLEANUP ═══════════════
local function CleanupTable(tbl)
    for _, obj in ipairs(tbl) do
        if obj and obj.Parent then
            local cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
            if cd and net then pcall(function() net.send("interaction", cd, "Pick Up") end) end
            pcall(function() obj:Destroy() end)
        end
    end
    for i = #tbl, 1, -1 do table.remove(tbl, i) end
end

local function ClearText() CleanupTable(textParts) end

-- ═══════════════ TEXT SPAWNER LOGIC ═══════════════
local function SpawnText(text, mode)
    if not net then return end
    text = string.upper(text)
    
    task.spawn(function()
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local startPos = hrp.Position + (hrp.CFrame.LookVector * 15)

        for i = 1, #text do
            local char = text:sub(i, i)
            local letterGrid = Alphabet[char]
            
            if letterGrid then
                ClearText()
                task.wait(0.3) -- Server sync

                for y = 1, 5 do
                    for x = 1, 5 do
                        if letterGrid[y]:sub(x, x) == "1" then
                            local pos = startPos + Vector3.new((x - 3) * 5, 2, (y - 3) * 5)
                            
                            if mode == "ITEMS" then
                                if #allItems > 0 then
                                    local item = allItems[math.random(1, #allItems)]
                                    pcall(function() net.get("large_place", item, CFrame.new(pos)) end)
                                end
                            elseif mode == "FIRE" then
                                if campfireItem then
                                    pcall(function() net.get("large_place", campfireItem, CFrame.new(pos)) end)
                                else
                                    local f = Instance.new("Part")
                                    f.Size = Vector3.new(3, 1, 3)
                                    f.Position = pos
                                    f.Anchored = true
                                    f.CanCollide = false
                                    f.Material = Enum.Material.Neon
                                    f.Color = Color3.fromRGB(255, 100, 0)
                                    f.Parent = workspace
                                    Instance.new("Fire", f).Size = 8
                                    table.insert(textParts, f)
                                end
                            end
                            task.wait(mode == "ITEMS" and 0.05 or 0.1)
                        end
                    end
                end
                task.wait(1.5) -- Wait before next letter
            end
        end
        task.wait(2)
        ClearText()
    end)
end

-- ═══════════════ TARGET FEATURES ═══════════════
local function ClearTrap(pos)
    if not net or not pos then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local isItem = false
            for _, item in ipairs(allItems) do
                if obj.Name == item.Name then isItem = true break end
            end
            if isItem then
                local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                if part and (part.Position - pos).Magnitude < 30 then
                    local cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
                    if cd then pcall(function() net.send("interaction", cd, "Pick Up") end) end
                    pcall(function() obj:Destroy() end)
                end
            end
        end
    end
end

local function SpawnTrap(pos)
    if not net or #allItems == 0 then return end
    local ground = pos - Vector3.new(0, 2.8, 0)
    for i = 1, 4 do
        local item = allItems[math.random(1, #allItems)]
        pcall(function() net.get("large_place", item, CFrame.new(ground + Vector3.new(math.random(-1,1), 0, math.random(-1,1)))) end)
        task.wait(0.02)
    end
    for layer = 0, 1 do
        for i = 1, 16 do
            local angle = (i / 16) * math.pi * 2
            local r = 2.5
            local p = ground + Vector3.new(math.cos(angle)*r, layer*3, math.sin(angle)*r)
            local item = allItems[math.random(1, #allItems)]
            pcall(function() net.get("large_place", item, CFrame.lookAt(p, ground)) end)
            task.wait(0.02)
        end
    end
    for i = 1, 4 do
        local item = allItems[math.random(1, #allItems)]
        pcall(function() net.get("large_place", item, CFrame.new(ground + Vector3.new(math.random(-1,1), 6, math.random(-1,1)))) end)
        task.wait(0.02)
    end
end

local function StartTrap(target)
    if isTrapping or not target.Character then return end
    isTrapping = true
    trapThread = task.spawn(function()
        while isTrapping do
            local hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local moved = lastPos and (hrp.Position - lastPos).Magnitude or 999
                if moved > 1 then
                    if lastPos then ClearTrap(hrp.Position) task.wait(0.1) end
                    SpawnTrap(hrp.Position)
                    lastPos = hrp.Position
                end
            end
            task.wait(0.1)
        end
    end)
end

local function StopTrap()
    isTrapping = false
    if trapThread then task.cancel(trapThread) trapThread = nil end
    if selectedPlayer and selectedPlayer.Character then
        local hrp = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then ClearTrap(hrp.Position) end
    end
end

local function FE_Void(target)
    local char = target.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    TakeOwnership(hrp)
    task.wait(0.1)
    local pos = CFrame.new(hrp.Position.X, 50000, hrp.Position.Z)
    for i = 1, 5 do
        char:PivotTo(pos)
        hrp.AssemblyLinearVelocity = Vector3.new(0, -99999, 0)
        task.wait(0.05)
    end
    pcall(function() hum.Health = 0 end)
end

local function FE_Fling(target)
    local hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    TakeOwnership(hrp)
    for i = 1, 10 do
        hrp.AssemblyLinearVelocity = Vector3.new(math.random(-100000, 100000), 100000, math.random(-100000, 100000))
        task.wait(0.05)
    end
end

local function FE_SizeLagger(target)
    local desc = getDesc(target)
    if not desc then return end
    local big = buildOutfit(desc, 5000)
    local small = buildOutfit(desc, 0.01)
    local normal = buildOutfit(desc, 1)
    task.spawn(function()
        for i = 1, 10 do
            pcall(function() net.send("wear_outfit_from_desc", big) end)
            task.wait(0.1)
            pcall(function() net.send("wear_outfit_from_desc", small) end)
            task.wait(0.1)
        end
        pcall(function() net.send("wear_outfit_from_desc", normal) end)
    end)
end

local function FE_CarDrop(target)
    local hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local cars = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildWhichIsA("VehicleSeat") then
            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
            if primary then table.insert(cars, {model = obj, part = primary}) end
        end
    end
    if #cars == 0 then return end
    local car = cars[math.random(1, #cars)]
    pcall(function()
        car.part:SetNetworkOwner(lp)
        task.wait(0.05)
        car.model:PivotTo(CFrame.new(hrp.Position + Vector3.new(0, 30, 0)))
        car.part.AssemblyLinearVelocity = Vector3.new(0, -200, 0)
    end)
end

-- ═══════════════ SELF: CAMPFIRE FOLLOWER ═══════════════
local function ToggleCampfireFollower()
    if activeThreads.Follower then
        task.cancel(activeThreads.Follower)
        activeThreads.Follower = nil
        CleanupTable(spawnedFireParts)
        return
    end

    activeThreads.Follower = task.spawn(function()
        local lastSpawnPos = nil
        while activeThreads.Follower do
            task.wait(0.3)
            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos = hrp.Position - Vector3.new(0, 2.5, 0)
                if not lastSpawnPos or (pos - lastSpawnPos).Magnitude > 3 then
                    lastSpawnPos = pos
                    
                    if campfireItem and net then
                        pcall(function() net.get("large_place", campfireItem, CFrame.new(pos)) end)
                        -- Dummy part for tracking limit
                        local dummy = Instance.new("Part")
                        dummy.Position = pos
                        dummy.Transparency = 1
                        dummy.Anchored = true
                        dummy.Parent = workspace
                        table.insert(spawnedFireParts, dummy)
                    else
                        -- Fallback if no campfire
                        local f = Instance.new("Part")
                        f.Size = Vector3.new(3, 1, 3)
                        f.Position = pos
                        f.Anchored = true
                        f.CanCollide = false
                        f.Material = Enum.Material.Neon
                        f.Color = Color3.fromRGB(255, 100, 0)
                        f.Parent = workspace
                        Instance.new("Fire", f).Size = 8
                        table.insert(spawnedFireParts, f)
                    end

                    if #spawnedFireParts > 15 then
                        local old = table.remove(spawnedFireParts, 1)
                        if old then old:Destroy() end
                    end
                end
            end
        end
    end)
end

local function Self_Wings()
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if workspace:FindFirstChild("SelfWings") then
        workspace.SelfWings:Destroy()
        return
    end
    local folder = Instance.new("Folder")
    folder.Name = "SelfWings"
    folder.Parent = workspace
    for i = -1, 1, 2 do
        local wing = Instance.new("Part")
        wing.Size = Vector3.new(1, 6, 3)
        wing.Color = Color3.fromRGB(0, 255, 255)
        wing.Material = Enum.Material.Neon
        wing.CanCollide = false
        wing.Massless = true
        wing.Parent = folder
        pcall(function() wing:SetNetworkOwner(lp) end)
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = hrp
        weld.Part1 = wing
        wing.CFrame = hrp.CFrame * CFrame.new(i * 1.5, 1, 1.5)
        weld.Parent = wing
    end
end

-- ═══════════════ GUI BUILD ═══════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateV21"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 500)
Main.Position = UDim2.new(0.5, -180, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(10, 8, 12)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 0, 100)

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 10, 15)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "☢ AUTH0R ULTIMATE V21"
Title.TextColor3 = Color3.fromRGB(255, 0, 100)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0.5, -17.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.FredokaOne
CloseBtn.TextSize = 16
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseButton1Click:Connect(function()
    StopTrap()
    for _, thread in pairs(activeThreads) do task.cancel(thread) end
    CleanupTable(spawnedFireParts)
    ClearText()
    ScreenGui:Destroy()
end)

-- Tabs
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, -20, 0, 32)
TabBar.Position = UDim2.new(0, 10, 0, 55)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 15, 20)
TabBar.BorderSizePixel = 0
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 6)

local TabTarget = Instance.new("TextButton", TabBar)
TabTarget.Size = UDim2.new(0.33, 0, 1, 0)
TabTarget.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
TabTarget.Text = "TARGET"
TabTarget.TextColor3 = Color3.fromRGB(255, 255, 255)
TabTarget.Font = Enum.Font.FredokaOne
TabTarget.TextSize = 12
Instance.new("UICorner", TabTarget).CornerRadius = UDim.new(0, 6)

local TabSelf = Instance.new("TextButton", TabBar)
TabSelf.Size = UDim2.new(0.33, 0, 1, 0)
TabSelf.Position = UDim2.new(0.33, 0, 0, 0)
TabSelf.BackgroundColor3 = Color3.fromRGB(20, 15, 20)
TabSelf.Text = "SELF"
TabSelf.TextColor3 = Color3.fromRGB(150, 150, 150)
TabSelf.Font = Enum.Font.FredokaOne
TabSelf.TextSize = 12
Instance.new("UICorner", TabSelf).CornerRadius = UDim.new(0, 6)

local TabText = Instance.new("TextButton", TabBar)
TabText.Size = UDim2.new(0.33, 0, 1, 0)
TabText.Position = UDim2.new(0.66, 0, 0, 0)
TabText.BackgroundColor3 = Color3.fromRGB(20, 15, 20)
TabText.Text = "TEXT"
TabText.TextColor3 = Color3.fromRGB(150, 150, 150)
TabText.Font = Enum.Font.FredokaOne
TabText.TextSize = 12
Instance.new("UICorner", TabText).CornerRadius = UDim.new(0, 6)

-- ═══════════════ TARGET TAB ═══════════════
local TargetTab = Instance.new("Frame", Main)
TargetTab.Size = UDim2.new(1, -20, 1, -95)
TargetTab.Position = UDim2.new(0, 10, 0, 95)
TargetTab.BackgroundTransparency = 1

local Status = Instance.new("TextLabel", TargetTab)
Status.Size = UDim2.new(1, 0, 0, 32)
Status.BackgroundColor3 = Color3.fromRGB(20, 15, 20)
Status.Text = "Target: None"
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.Font = Enum.Font.FredokaOne
Status.TextSize = 13
Instance.new("UICorner", Status).CornerRadius = UDim.new(0, 6)

local ListBtn = Instance.new("TextButton", TargetTab)
ListBtn.Size = UDim2.new(1, 0, 0, 32)
ListBtn.Position = UDim2.new(0, 0, 0, 40)
ListBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ListBtn.Text = "▼ SELECT TARGET"
ListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ListBtn.Font = Enum.Font.FredokaOne
ListBtn.TextSize = 14
ListBtn.ZIndex = 5
Instance.new("UICorner", ListBtn).CornerRadius = UDim.new(0, 6)

local ListFrame = Instance.new("ScrollingFrame", TargetTab)
ListFrame.Size = UDim2.new(1, 0, 0, 180)
ListFrame.Position = UDim2.new(0, 0, 0, 78)
ListFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 15)
ListFrame.BorderSizePixel = 0
ListFrame.Visible = false
ListFrame.ZIndex = 100
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", ListFrame).CornerRadius = UDim.new(0, 6)
local ListLayout = Instance.new("UIListLayout", ListFrame)
ListLayout.Padding = UDim.new(0, 3)

local FeatureFrame = Instance.new("Frame", TargetTab)
FeatureFrame.Size = UDim2.new(1, 0, 0, 280)
FeatureFrame.Position = UDim2.new(0, 0, 0, 78)
FeatureFrame.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", FeatureFrame)
grid.CellSize = UDim2.new(0.48, -3, 0, 36)
grid.CellPadding = UDim2.new(0, 3, 0, 4)

local function TargetBtn(text, color, cb)
    local b = Instance.new("TextButton", FeatureFrame)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.FredokaOne
    b.TextSize = 12
    b.TextWrapped = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

local trapBtn = TargetBtn("REAL TRAP", Color3.fromRGB(255, 0, 100), function()
    if not selectedPlayer then return end
    if isTrapping then
        StopTrap()
        trapBtn.Text = "REAL TRAP"
        trapBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    else
        StartTrap(selectedPlayer)
        trapBtn.Text = "STOP TRAP"
        trapBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    end
end)
TargetBtn("VOID", Color3.fromRGB(200, 50, 50), function() if selectedPlayer then FE_Void(selectedPlayer) end end)
TargetBtn("FLING", Color3.fromRGB(150, 50, 200), function() if selectedPlayer then FE_Fling(selectedPlayer) end end)
TargetBtn("SIZE LAG", Color3.fromRGB(255, 150, 0), function() if selectedPlayer then FE_SizeLagger(selectedPlayer) end end)
TargetBtn("CAR DROP", Color3.fromRGB(255, 100, 50), function() if selectedPlayer then FE_CarDrop(selectedPlayer) end end)

-- ═══════════════ SELF TAB ═══════════════
local SelfTab = Instance.new("Frame", Main)
SelfTab.Size = UDim2.new(1, -20, 1, -95)
SelfTab.Position = UDim2.new(0, 10, 0, 95)
SelfTab.BackgroundTransparency = 1
SelfTab.Visible = false

local SelfFrame = Instance.new("Frame", SelfTab)
SelfFrame.Size = UDim2.new(1, 0, 1, 0)
SelfFrame.BackgroundTransparency = 1

local sgrid = Instance.new("UIGridLayout", SelfFrame)
sgrid.CellSize = UDim2.new(0.48, -3, 0, 36)
sgrid.CellPadding = UDim2.new(0, 3, 0, 4)

local function SelfBtn(text, color, cb)
    local b = Instance.new("TextButton", SelfFrame)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.FredokaOne
    b.TextSize = 12
    b.TextWrapped = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

SelfBtn("🔥 CAMPFIRE\nFOLLOWER", Color3.fromRGB(255, 100, 0), function() ToggleCampfireFollower() end)
SelfBtn("🦅 NEON WINGS", Color3.fromRGB(0, 255, 255), function() Self_Wings() end)

-- ═══════════════ TEXT TAB ═══════════════
local TextTab = Instance.new("Frame", Main)
TextTab.Size = UDim2.new(1, -20, 1, -95)
TextTab.Position = UDim2.new(0, 10, 0, 95)
TextTab.BackgroundTransparency = 1
TextTab.Visible = false

local TextInput = Instance.new("TextBox", TextTab)
TextInput.Size = UDim2.new(1, 0, 0, 45)
TextInput.Position = UDim2.new(0, 0, 0, 10)
TextInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TextInput.PlaceholderText = "Type Name (e.g. MANAS)"
TextInput.Text = ""
TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TextInput.Font = Enum.Font.FredokaOne
TextInput.TextSize = 16
Instance.new("UICorner", TextInput).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", TextInput).Color = Color3.fromRGB(0, 255, 150)

local function TextBtn(text, y, color, mode)
    local btn = Instance.new("TextButton", TextTab)
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function()
        if TextInput.Text ~= "" then SpawnText(TextInput.Text, mode) end
    end)
end

TextBtn("🪑 SPAWN WITH ITEMS", 70, Color3.fromRGB(50, 150, 255), "ITEMS")
TextBtn("🔥 SPAWN WITH CAMPFIRE", 130, Color3.fromRGB(255, 100, 0), "FIRE")

-- ═══════════════ TAB LOGIC ═══════════════
local function SwitchTab(tab)
    TargetTab.Visible = (tab == "TARGET")
    SelfTab.Visible = (tab == "SELF")
    TextTab.Visible = (tab == "TEXT")

    TabTarget.BackgroundColor3 = (tab == "TARGET") and Color3.fromRGB(255, 0, 100) or Color3.fromRGB(20, 15, 20)
    TabTarget.TextColor3 = (tab == "TARGET") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    
    TabSelf.BackgroundColor3 = (tab == "SELF") and Color3.fromRGB(255, 0, 100) or Color3.fromRGB(20, 15, 20)
    TabSelf.TextColor3 = (tab == "SELF") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    
    TabText.BackgroundColor3 = (tab == "TEXT") and Color3.fromRGB(255, 0, 100) or Color3.fromRGB(20, 15, 20)
    TabText.TextColor3 = (tab == "TEXT") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
end

TabTarget.MouseButton1Click:Connect(function() SwitchTab("TARGET") end)
TabSelf.MouseButton1Click:Connect(function() SwitchTab("SELF") end)
TabText.MouseButton1Click:Connect(function() SwitchTab("TEXT") end)

local function ShowList()
    ListFrame.Visible = not ListFrame.Visible
    if ListFrame.Visible then
        ListBtn.Text = "▲ HIDE LIST"
        for _, c in ipairs(ListFrame:GetChildren()) do 
            if c:IsA("TextButton") then c:Destroy() end 
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp then
                local b = Instance.new("TextButton", ListFrame)
                b.Size = UDim2.new(1, -8, 0, 32)
                b.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
                b.Text = p.Name
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
                b.Font = Enum.Font.FredokaOne
                b.TextSize = 13
                b.ZIndex = 101
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
                local selectHandler = function()
                    selectedPlayer = p
                    Status.Text = "Target: " .. p.Name
                    Status.TextColor3 = Color3.fromRGB(0, 255, 150)
                    ListFrame.Visible = false
                    ListBtn.Text = "▼ SELECT TARGET"
                end
                b.MouseButton1Click:Connect(selectHandler)
                b.Activated:Connect(selectHandler)
            end
        end
    else
        ListBtn.Text = "▼ SELECT TARGET"
    end
end

ListBtn.MouseButton1Click:Connect(ShowList)
ListBtn.Activated:Connect(ShowList)

pcall(function()
    local guiParent = gethui and gethui() or CoreGui
    ScreenGui.Parent = guiParent
end)
if not ScreenGui.Parent then ScreenGui.Parent = lp:WaitForChild("PlayerGui") end
print("[AUTH0R] Ultimate V21 Loaded (Text + Campfire Follower + Troll)")