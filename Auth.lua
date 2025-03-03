-- Auth.lua

local LucheVitae = {}
LucheVitae.__index = LucheVitae

-- Armazenamento interno para configurações
local Configs = {}

-- Método para configurar o serviço
function LucheVitae:Settings(config)
    Configs.Service = config.Service or "DefaultService"
    Configs.KickBan = config.KickBan or false
    print("[LucheVitae] Configurado serviço:", Configs.Service)
    print("[LucheVitae] Configurado serviço:", Configs.KickBan)
end

-- Método para imprimir o serviço configurado
function LucheVitae:PrintService()
    if Configs.Service then
        print("[LucheVitae] Serviço atual:", Configs.Service)
    else
        print("[LucheVitae] Nenhum serviço configurado.")
    end
end

function LucheVitae:Implement()
  pcall(function()
    local ExecutorName = identifyexecutor() or "NO NAME!!!"
    local Gamepado = "false"
    local Toque = "false"
    local Teclado = "false"
    if game:GetService("UserInputService").TouchEnabled == true then
      Toque = "__true__"
    end
    if game:GetService("UserInputService").KeyboardEnabled == true then
      Teclado = "__true__"
    end
    if game:GetService("UserInputService").GamepadEnabled == true then
      Gamepado = "__true__"
    end
    local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
    local response = httrest({
      Url = "http://localhost:3000/api/integrity",
      Method = "POST",
      Headers = {
        ["service"] = tostring(Configs.Service),
        ["executor"] = tostring(ExecutorName),
        ["gamename"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
        ["gameid"] = tostring(game.PlaceId),
        ["serversize"] = tostring(#game.Players:GetPlayers()) .. "/" .. tostring(game.Players.MaxPlayers),
        ["jobid"] = tostring(game.JobId),
        ["username"] = tostring(game:GetService("Players").LocalPlayer.Name),
        ["displayname"] = tostring(game:GetService("Players").LocalPlayer.DisplayName),
        ["userid"] = tostring(game:GetService("Players").LocalPlayer.UserId),
        ["clientid"] = tostring(game:GetService("RbxAnalyticsService"):GetClientId()),
        ["touch"] = tostring(Toque),
        ["gamepad"] = tostring(Gamepado),
        ["keyboard"] = tostring(Teclado)
      }
    })
  
    if Configs.KickBan == true and response.StatusCode == 401 then
      game:GetService("Players").LocalPlayer:Kick("\n\nYou are permanently banned from this service, don't try to bypass this\n\nProvided by Luche Vitae ™")
    end
  end)
end

-- Metamétodo para adicionar novas chaves
local mt = {
    __newindex = function(self, key, value)
        print("Nova chave adicionada:", key, "com o valor:", value)
        rawset(self, key, value)
    end,
    __metatable = false -- Protege a metatable
}

-- Define a metatable para a biblioteca
return setmetatable(LucheVitae, mt)