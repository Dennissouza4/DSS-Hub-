local Rayfield = loadstring(game:HttpGet('https://pastebin.com/raw/0i6RiH6U'))() -- importar a porra do rayfield

if not Rayfield then
    warn("DS Software | Rayfield Library Failed To Load. Script Terminated.")
    return
end

-- Walkspeed Scripts Section, NÃO MECHE NESSA PORRA PELO AMOR DE DEUS, FOI 2 HORAS DEBUGANDO ESSA MERDAAAAAAAAAAA
local Window = Rayfield:CreateWindow({
    Name = "DSS Hub - Beta",
    Icon = 133774712356480, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "DSS_Hub",
    LoadingSubtitle = "by DS Software.",
    ShowText = "DS Software Hub", -- for mobile users to unhide rayfield, change if you'd like
    Theme = "DssHub",             -- Check https://docs.sirius.menu/rayfield/configuration/themes

    ToggleUIKeybind = "K",        -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

    ConfigurationSaving = {
        Enabled = false,  -- salva tuas config
        FolderName = nil, -- Create a custom folder for your hub/game
        FileName = "DSS Hub"
    },

    Discord = {
        Enabled = true,                           -- Prompt the user to join your Discord server if their executor supports it
        Invite = "https://discord.gg/wM2gG5dH6Z", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
        RememberJoins = true                      -- Set this to false to make them join the discord every time they load it up
    },

    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
        Title = "DSS Hub by DS Software",
        Subtitle = "DSS Hub Em Desenvolvimento. Mais Informações No Server Do Discord.",
        Note = "Apenas a WhiteList Obtem a Key.",                                     -- Use this to tell the user how to get a key
        FileName = "Key",                                                             -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
        SaveKey = true,                                                               -- The user's key will be saved, but if you change the key, they will be unable to use your script
        GrabKeyFromSite = false,                                                      -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
        Key = { "DS Software", "dennissouza4", "GUARANA!", "tedio", "!TestUser2025" } -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

-- Variaveis.


-- milagre, tomei vergonha na cara e arrumei a porra das variaveis

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local selectedPlayer = nil
local spectating = false

local currentSpeed = nil -- variável para armazenar o valor do input


local selectedColor = Color3.fromRGB(255, 255, 255) -- Default to white color



local Player_Backpack = Plr:FindFirstChild("Backpack")
if not Player_Backpack then
    Player_Backpack = nil
    print("DS Software | Player Backpack Not Found. Ignoring Service Enabled.")
end



-- variaveis end

-- notificar quando o script abrir.
Rayfield:Notify({
    Title = "👋 Olá, Seja Bem Vindo! ",
    Content = "Seja Bem Vindo ao DSS Hub, " .. Plr.Name,
    Duration = 6.5,
    Image = "scroll-text",
})



local ScriptHomeTab = Window:CreateTab("Home", "scroll-text") -- Title, Image

local HomeSection = ScriptHomeTab:CreateSection("DSS Hub - Home")

local HomeLabel2 = ScriptHomeTab:CreateLabel("DS Software Hub - Beta Testing Release 1.0.1")

-- Fechar a porra do Script.
local CloseButton = ScriptHomeTab:CreateButton({
    Name = "Fechar o Script",
    Callback = function()
        Rayfield:Destroy()
    end,
})












--// Referência ao jogador local
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer

--// Criação da aba e seção
local PlantVSBrainrotTab = Window:CreateTab("Plants vs Brainrot", "leaf")
local DuplicationSection = PlantVSBrainrotTab:CreateSection("Duplicação de Itens")

--// Variáveis de controle
local duplicateCount = 1
local selectedItemName = nil

--// Input da quantia de duplicação
local DuplicateInput = PlantVSBrainrotTab:CreateInput({
    Name = "Quantia De Duplicação",
    CurrentValue = "",
    PlaceholderText = "Número de Duplicação",
    RemoveTextAfterFocusLost = false,
    Flag = "DuplicateInput",
    Callback = function(Text)
        duplicateCount = tonumber(Text)
    end,
})

--// Verifica a Backpack
local Player_Backpack = Plr:FindFirstChild("Backpack")
if not Player_Backpack then
    warn("DS Software | Player Backpack Not Found. Ignoring Service Enabled.")
end

--// Cria o dropdown vazio
local DuplicateItemSelect = PlantVSBrainrotTab:CreateDropdown({
    Name = "Selecionar Item Para Duplicar",
    Options = {},
    CurrentOption = nil,
    MultipleOptions = false,
    Flag = "DuplicateItemDropdown",
    Callback = function(Options)
        selectedItemName = Options[1]
    end,
})

--// Função para atualizar o dropdown com os itens da backpack
local function UpdateDropdownOptions()
    local options = {}
    if Player_Backpack then
        for _, item in ipairs(Player_Backpack:GetChildren()) do
            table.insert(options, item.Name)
        end
    end
    DuplicateItemSelect:Refresh(options)
end

--// Atualiza automaticamente quando a backpack mudar
if Player_Backpack then
    Player_Backpack.ChildAdded:Connect(UpdateDropdownOptions)
    Player_Backpack.ChildRemoved:Connect(UpdateDropdownOptions)
end

-- Atualiza uma vez no início
UpdateDropdownOptions()

--// Botão de duplicação
local DuplicateButton = PlantVSBrainrotTab:CreateButton({
    Name = "Executar Duplicação",
    Callback = function()
        if not Player_Backpack then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Mochila não encontrada. Tente novamente.",
                Duration = 6.5,
                Image = "triangle-alert",
            })
            return
        end

        if not selectedItemName then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Selecione um item primeiro!",
                Duration = 6.5,
                Image = "triangle-alert",
            })
            return
        end

        if not duplicateCount or duplicateCount <= 0 then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Quantia inválida. Digite um número maior que 0.",
                Duration = 6.5,
                Image = "triangle-alert",
            })
            return
        end

        local itemToDuplicate = Player_Backpack:FindFirstChild(selectedItemName)
        if not itemToDuplicate then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Item não encontrado na mochila!",
                Duration = 6.5,
                Image = "triangle-alert",
            })
            return
        end

        -- Limite de segurança para evitar crash
        if duplicateCount > 50 then
            Rayfield:Notify({
                Title = "Aviso",
                Content = "Limite máximo de duplicação é 50 por vez.",
                Duration = 6.5,
                Image = "triangle-alert",
            })
            duplicateCount = 50
        end

        -- Duplicar o item
        for i = 1, duplicateCount do
            local clonedItem = itemToDuplicate:Clone()
            clonedItem.Parent = Player_Backpack
            task.wait(0.05)
        end

        Rayfield:Notify({
            Title = "Duplicação Concluída!",
            Content = string.format("Item '%s' duplicado %d vezes!", selectedItemName, duplicateCount),
            Duration = 6.5,
            Image = "bookmark-check",
        })

        -- Atualiza dropdown após duplicação
        UpdateDropdownOptions()
    end,
})












local UniversalTab = Window:CreateTab("Universal", "wrench")

UniversalTab:CreateSection("Player Walkspeed")

local WalkInput = UniversalTab:CreateInput({
    Name = "Walkspeed Do Player",
    CurrentValue = "",
    PlaceholderText = "Player Walkspeed",
    RemoveTextAfterFocusLost = false,
    Flag = "WalkSpeedInput",
    Callback = function(Text)
        currentSpeed = tonumber(Text)
    end,
})

local ExecuteWalkspeed = UniversalTab:CreateButton({
    Name = "Setar Walkspeed",
    Callback = function()
        if currentSpeed then
            if Plr.Character and Plr.Character:FindFirstChildOfClass("Humanoid") then
                Plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentSpeed

                Rayfield:Notify({
                    Title = "Velocidade Atualizada!",
                    Content = "Velocidade Atual:" .. tostring(currentSpeed),
                    Duration = 6.5,
                    Image = "bookmark-check",
                })
            end
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Velocidade Inválida. Tente Novamente",
                Duration = 6.5,
                Image = "triangle-alert",
            })
        end
    end,
})

local SpectateSection = UniversalTab:CreateSection("Espectar Player")

-- Criação do Dropdown com opções vazias por enquanto
local SpecDropdown = UniversalTab:CreateDropdown({
    Name = "Spectate Player",
    Options = {},
    CurrentOption = nil,
    MultipleOptions = false,
    Flag = "PlayerDropdown",
    Callback = function(Options)
        local playerName = Options[1]
        selectedPlayer = Players:FindFirstChild(playerName)
    end,
})

-- Criação do Toggle de spectate
local SpectplayerToogle = UniversalTab:CreateToggle({
    Name = "Spectate Player",
    CurrentValue = false,
    Flag = "SpectatePlayerToggle",
    Callback = function(Value)
        spectating = Value

        if spectating and selectedPlayer and selectedPlayer.Character then
            task.spawn(function()
                while spectating and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") do
                    Camera.CameraSubject = selectedPlayer.Character:FindFirstChild("Humanoid")
                    Camera.CameraType = Enum.CameraType.Custom
                    task.wait(0.1)
                end
            end)
        else
            -- Volta a câmera para o jogador local
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
                Camera.CameraType = Enum.CameraType.Custom
            end
        end
    end,
})

local TeleportPlayer = UniversalTab:CreateButton({
    Name = "Teleportar Player",
    Callback = function()
        if selectedPlayer and selectedPlayer.Character and LocalPlayer.Character then
            local targetHumanoidRootPart = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
            local localHumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if targetHumanoidRootPart and localHumanoidRootPart then
                localHumanoidRootPart.CFrame = targetHumanoidRootPart.CFrame +
                    Vector3.new(0, 5, 0) -- Teleporta 5 unidades acima do jogador alvo
                Rayfield:Notify({
                    Title = "Teleportado!",
                    Content = "Você foi teleportado para " .. selectedPlayer.Name,
                    Duration = 6.5,
                    Image = "bookmark-check",
                })
            else
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "Não foi possível encontrar o HumanoidRootPart.",
                    Duration = 6.5,
                    Image = "triangle-alert",
                })
            end
        else
            Rayfield:Notify({
                Title = "Erro",
                Content = "Nenhum jogador selecionado ou o jogador não está disponível.",
                Duration = 6.5,
                Image = "triangle-alert",
            })
        end
    end,

})



-- Função para atualizar o dropdown com os jogadores atuais (exceto o local)
local function UpdatePlayerList()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(names, player.Name)
        end
    end

    SpecDropdown:Refresh(names, true)
end

-- Atualiza o dropdown quando alguém entra ou sai
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

-- Atualiza logo ao iniciar
UpdatePlayerList()

UniversalTab:CreateSection("ESP Player (Beta)")

-- ESP Players (Outline + Line)
-- Red outline/aura (contorno vermelho)



-- Variables
local espEnabled = false
local localAttachment = nil
local espOutlines = {}          -- Table to track outlines: player -> outline instance
local espBeams = {}             -- Table to track beams: player -> beam instance
local espTargetAttachments = {} -- Table to track target attachments: player -> attachment instance
local espNameTags = {}          -- player -> BillboardGui


-- Function to create BillboardGui with player's name
local function addNameBillboard(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then return end
    local head = player.Character.Head

    if head:FindFirstChild("ESPNameTag") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPNameTag"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 100, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Name = "Text"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.Text = player.Name
    label.TextColor3 = Color3.fromRGB(255, 0, 0) -- será alterado via ColorPicker
    label.TextStrokeTransparency = 1             -- sem contorno
    label.TextScaled = true
    label.Font = Enum.Font.GothamMedium
    label.Parent = billboard

    billboard.Parent = head
    espNameTags[player] = billboard
end




-- Function to create or update local attachment
local function setupLocalAttachment()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    local hrp = LocalPlayer.Character.HumanoidRootPart
    if not hrp:FindFirstChild("LocalESPAttach") then
        localAttachment = Instance.new("Attachment")
        localAttachment.Name = "LocalESPAttach"
        localAttachment.Parent = hrp
    else
        localAttachment = hrp.LocalESPAttach
    end

    return localAttachment
end

-- Function to add ESP to a specific player (outline + line)
local function addESPToPlayer(player)
    if player == LocalPlayer or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local character = player.Character
    local hrp = character.HumanoidRootPart

    -- Create or update outline (red aura/contorno)
    if not espOutlines[player] then
        local outline = Instance.new("BoxHandleAdornment")
        outline.Name = "ESPOutline"
        outline.Adornee =
            character                                                          -- Adornee to the whole character for better coverage
        outline.Size = character:GetExtentsSize() + Vector3.new(0.5, 0.5, 0.5) -- Slightly larger for aura effect
        outline.Transparency = 0.7
        outline.Color3 = Color3.fromRGB(255, 0, 0)                             -- Red outline/aura
        outline.AlwaysOnTop = true
        outline.ZIndex = 10
        outline.Parent = hrp -- Parent to HRP for persistence
        espOutlines[player] = outline
    end

    -- Create local attachment if needed
    local localAttach = setupLocalAttachment()
    if not localAttach then
        return
    end

    -- Create target attachment
    if not espTargetAttachments[player] then
        local targetAttach = Instance.new("Attachment")
        targetAttach.Name = "TargetESPAttach"
        targetAttach.Parent = hrp
        espTargetAttachments[player] = targetAttach
    end

    local targetAttach = espTargetAttachments[player]

    -- Create beam (green line)
    if not espBeams[player] then
        local beam = Instance.new("Beam")
        beam.Name = "ESPLine_" .. player.Name
        beam.Attachment0 = localAttach
        beam.Attachment1 = targetAttach
        beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)) -- Green line
        beam.Width0 = 0.1
        beam.Width1 = 0.1
        beam.Transparency = NumberSequence.new(0.3) -- Slightly less transparent
        beam.Parent = Workspace                     -- Parent to Workspace for visibility
        espBeams[player] = beam
    end
    addNameBillboard(player)
end

-- Function to remove ESP from a specific player
local function removeESPFromPlayer(player)
    if espOutlines[player] then
        espOutlines[player]:Destroy()
        espOutlines[player] = nil
    end

    if espTargetAttachments[player] then
        espTargetAttachments[player]:Destroy()
        espTargetAttachments[player] = nil
    end

    if espBeams[player] then
        espBeams[player]:Destroy()
        espBeams[player] = nil
    end

    if espNameTags[player] then
        espNameTags[player]:Destroy()
        espNameTags[player] = nil
    end
end

-- Function to setup ESP for all current players
local function setupAllESP()
    -- Clear any existing (in case of respawn)
    for player, _ in pairs(espOutlines) do
        removeESPFromPlayer(player)
    end

    -- Setup local attachment
    setupLocalAttachment()

    -- Add to all other players
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            addESPToPlayer(player)
        end
    end
end

-- Function to disable all ESP
local function disableAllESP()
    for player, _ in pairs(espOutlines) do
        removeESPFromPlayer(player)
    end
    espOutlines = {}
    espTargetAttachments = {}
    espBeams = {}
    if localAttachment then
        localAttachment:Destroy()
        localAttachment = nil
    end
end

-- Toggle callback
local ESPPlayerToogle = UniversalTab:CreateToggle({
    Name = "ESP Player",
    CurrentValue = false,
    Flag = "ESPPlayerToggle",
    Callback = function(Value)
        espEnabled = Value
        if Value then
            -- Setup for current state
            setupAllESP()

            -- Handle existing players' respawns
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local connection
                    connection = player.CharacterAdded:Connect(function()
                        if espEnabled then
                            task.wait(1) -- Wait for full load
                            addESPToPlayer(player)
                        end
                    end)
                    -- Store connection if needed, but for simplicity, we recreate on toggle
                end
            end

            -- Handle new players
            local playerAddedConn
            playerAddedConn = Players.PlayerAdded:Connect(function(player)
                if player ~= LocalPlayer and espEnabled then
                    player.CharacterAdded:Connect(function()
                        task.wait(1)
                        addESPToPlayer(player)
                    end)
                end
            end)

            -- Handle local player respawn
            local localCharAddedConn
            localCharAddedConn = LocalPlayer.CharacterAdded:Connect(function()
                if espEnabled then
                    task.wait(1)
                    -- Recreate local attachment and re-add lines to current players
                    setupLocalAttachment()
                    for _, otherPlayer in ipairs(Players:GetPlayers()) do
                        if otherPlayer ~= LocalPlayer and espBeams[otherPlayer] then
                            -- Update beam's Attachment0
                            if localAttachment then
                                espBeams[otherPlayer].Attachment0 = localAttachment
                            end
                        else
                            addESPToPlayer(otherPlayer)
                        end
                    end
                end
            end)

            -- Note: Connections are created here; in a full script, you might want to store and disconnect them on toggle off to avoid leaks.
            -- For this example, they will persist but only act if espEnabled is true.
        else
            disableAllESP()
        end
    end,
})


local EspLineSize = UniversalTab:CreateSlider({
    Name = "Tamanho Da Linha Do ESP",
    Range = { 0.1, 5 },
    Increment = 0.1,
    Suffix = "Size",
    CurrentValue = 0.2,
    Flag = "ESPLineSizeSlider",
    Callback = function(Value)
        -- Update line size
        for _, beam in pairs(espBeams) do
            if beam and beam:IsA("Beam") then
                beam.Width0 = Value
                beam.Width1 = Value
            end
        end
    end,
})



local EspColorPicker = UniversalTab:CreateColorPicker({
    Name = "Cor Do ESP",
    Color = Color3.fromRGB(255, 0, 0), -- Default to red
    Flag = "ESPColorPicker",
    Callback = function(Value)
        -- Update outline color
        for _, outline in pairs(espOutlines) do
            if outline and outline:IsA("BoxHandleAdornment") then
                outline.Color3 = Value
            end
        end

        for _, beam in pairs(espBeams) do
            if beam and beam:IsA("Beam") then
                beam.Color = ColorSequence.new(Value)
            end
        end

        -- Update name tag color
        for _, nameTag in pairs(espNameTags) do
            if nameTag and nameTag:IsA("BillboardGui") then
                local label = nameTag:FindFirstChild("Text")
                if label and label:IsA("TextLabel") then
                    label.TextColor3 = Value
                end
            end
        end
    end
}) -- esp end





local UIS = game:GetService('UserInputService')
local Player = game:GetService('Players').LocalPlayer
local Camera = workspace.CurrentCamera
local Flying = false
local Connection = nil

function toggleFly()
    if Flying then
        local char = Player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then
            return
        end
        local rootPart = char.HumanoidRootPart
        local hum = char.Humanoid

        hum.PlatformStand = true
        local currentCF = rootPart.CFrame
        Connection = game:GetService('RunService').RenderStepped:Connect(function()
            local moveVec = Vector3.new()
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.E) then moveVec = moveVec + Camera.CFrame.UpVector end
            if UIS:IsKeyDown(Enum.KeyCode.Q) then moveVec = moveVec - Camera.CFrame.UpVector end

            rootPart.AssemblyLinearVelocity = Vector3.zero
            rootPart.AssemblyAngularVelocity = Vector3.zero
            currentCF += moveVec
            rootPart.CFrame = CFrame.lookAt(
                currentCF.Position,
                currentCF.Position + (Camera.CFrame.LookVector * 2)
            )
        end)
    else
        if Connection then
            Connection:Disconnect()
            Connection = nil
        end
        local char = Player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
        end
    end
end

UniversalTab:CreateSection("Fly")

local FlyToggle = UniversalTab:CreateToggle({
    Name = "Ativar Fly",
    CurrentValue = false,
    Flag = "FlyTurnOn",
    Callback = function(Value)
        Flying = Value
        toggleFly()
    end,
})




local vehiclesFolder = workspace:FindFirstChild("Vehicles")
local PlayerCar = nil

if vehiclesFolder then
    PlayerCar = vehiclesFolder:FindFirstChild(Plr.Name .. "Car")
end

-- nunca use wait for child acima pq quando vc usa o script n executa ent ele espera o carro pra carregar

if not PlayerCar then
    PlayerCar = nil
    print("DS Software | PlayerCar Not Found. Ignoring Service Enabled.")
end

local PlayerCar = nil
local DriverSeat = nil
local Turbo = nil
local MaxSpeed = nil


local BrookhavenTab = Window:CreateTab("Brookhaven RP 🏡", 0) -- Title, Image
-- brookhaven Scripts
BrookhavenTab:CreateSection("Cor do Veiculo")

-- Create the Color Picker
local ColorPicker = BrookhavenTab:CreateColorPicker({
    Name = "Cor Do Veículo",

    Color = selectedColor,
    Flag = "ColorVehicle",
    Callback = function(Value)
        selectedColor = Value -- Store the selected color
    end
})

-- Create the "Executar Cor" button
local ExecuteColor = BrookhavenTab:CreateButton({
    Name = "Executar Cor",
    Callback = function()
        -- Check if the player is in a car and if the car has a part called "Color"
        -- Verifica se o jogador está em um carro e se a parte "Body" existe
        if PlayerCar and PlayerCar:FindFirstChild("Body") then
            local Body = PlayerCar.Body
            local colorContainer = Body:FindFirstChild("Color")

            if colorContainer then
                local partsChanged = 0

                for _, part in ipairs(colorContainer:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Color = selectedColor
                        partsChanged += 1
                    end
                end

                if partsChanged > 0 then
                    Rayfield:Notify({
                        Title = "Cor Atualizada!",
                        Content = "Cor do veículo aplicada em " .. partsChanged .. " partes.",
                        Duration = 6.5,
                        Image = "bookmark-check",
                    })
                else
                    Rayfield:Notify({
                        Title = "Aviso",
                        Content = "Nenhuma parte modificável encontrada dentro de 'Color'.",
                        Duration = 6.5,
                        Image = "alert-triangle",
                    })
                end
            else
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "A pasta 'Color' não foi encontrada dentro de 'Body'.",
                    Duration = 6.5,
                    Image = "triangle-alert",
                })
            end
        else
            Rayfield:Notify({
                Title = "Erro",
                Content = "Veículo Não Encontrado. Entre em um veículo e tente novamente.",
                Duration = 6.5,
                Image = "triangle-alert",
            })
        end
    end,
})

local function DetectCar()
    local success, result = pcall(function()
        return Workspace:WaitForChild("Vehicles"):WaitForChild(Plr.Name .. "Car")
    end)

    if success and result then
        PlayerCar = result
        DriverSeat = PlayerCar:WaitForChild("Seats"):WaitForChild("VehicleSeat")
        Turbo = DriverSeat:FindFirstChild("Turbo")
        MaxSpeed = DriverSeat:FindFirstChild("MaxSpeed")

        return true
    else
        return false, result
    end
end

local UpdateButton = BrookhavenTab:CreateButton({
    Name = "Atualizar Veículo",
    Callback = function()
        local success, err = DetectCar()

        if success then
            Rayfield:Notify({
                Title = "Veículo Atualizado!",
                Content = "O script agora está rastreando o veículo atual.",
                Duration = 6.5,
                Image = "bookmark-check",
            })
        else
            Rayfield:Notify({
                Title = "Erro ao detectar o veículo!",
                Content = tostring(err),
                Duration = 6.5,
                Image = "triangle-alert",
            })
        end
    end,
})

BrookhavenTab:CreateSection("Motor")

local EngineTurboInput = BrookhavenTab:CreateInput({
    Name = "Turbo",
    CurrentValue = "",
    PlaceholderText = "Aumenta a Aceleração",
    RemoveTextAfterFocusLost = false,
    Flag = "TurboInput",
    Callback = function(Text)
        if Turbo == nil then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Nenhum veículo detectado. Clique em 'Atualizar Veículo' primeiro.",
                Duration = 6.5,
                Image = "triangle-alert",
            })
            return
        end

        if Text == "" then
            Turbo.Value = 11.3
        else
            local turboValue = tonumber(Text)
            if turboValue then
                Turbo.Value = turboValue
                Rayfield:Notify({
                    Title = "Turbo Atualizado!",
                    Content = "Turbo Atualizado Para: " .. tostring(turboValue),
                    Duration = 6.5,
                    Image = "bookmark-check",
                })
            else
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "Valor Inválido. Tente Novamente.",
                    Duration = 6.5,
                    Image = "triangle-alert",
                })
            end
        end
    end,
})

local EngineMaxSpeedInput = BrookhavenTab:CreateInput({
    Name = "MaxSpeed",
    CurrentValue = "",
    PlaceholderText = "Aumenta a Velocidade",
    RemoveTextAfterFocusLost = false,
    Flag = "MaxSpeedInput",
    Callback = function(Text)
        if MaxSpeed == nil then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Nenhum veículo detectado. Clique em 'Atualizar Veículo' primeiro.",
                Duration = 6.5,
                Image = "triangle-alert",
            })
            return
        end

        if Text == "" then
            MaxSpeed.Value = 25
        else
            local maxSpeedValue = tonumber(Text)
            if maxSpeedValue then
                MaxSpeed.Value = maxSpeedValue
                Rayfield:Notify({
                    Title = "MaxSpeed Atualizado!",
                    Content = "MaxSpeed Atualizado Para: " .. tostring(maxSpeedValue),
                    Duration = 6.5,
                    Image = "bookmark-check",
                })
            else
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "Valor Inválido. Tente Novamente.",
                    Duration = 6.5,
                    Image = "triangle-alert",
                })
            end
        end
    end,
})
