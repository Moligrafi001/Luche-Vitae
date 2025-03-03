local LucheVitae = {}
LucheVitae.__index = LucheVitae

local Configs = {}

function LucheVitae:PrintService()
  print(Configs.Service)
end

function LucheVitae:Settings(config)
  Configs.Service = config.Service or "DefaultService"
  print("[LucheVitae] Configurado serviço:", Configs.Service)
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
  
    if not response or response.StatusCode == 401 then
      game:GetService("Players").LocalPlayer:Kick("\n\nYou are permanently banned from this service, don't try to bypass this\n\nProvided by Luche Vitae ™")
    end
  end)
end

function LucheVitae:GetKey()
  setclipboard("http://localhost:3000/getkey/?service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId())
end

function LucheVitae:AuthKey(key)
  local response = request({
    Url = "http://localhost:3000/api/key?type=check&key=" .. key .. "&service=" .. Settings.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId(),
    Method = "GET"
  })
  
  if response.StatusCode == 200 then
    return "valid"
  elseif response.StatusCode == 404 then
    return "invalid"
  elseif response.StatusCode == 410 then
    return "expired"
  else
    return false
  end
end

if not Configs.Service then
  return error("[ Luche Vitae ] - NO SERVICE ADDED")
end

local mt = {
    __newindex = function(self, key, value)
        print("Nova chave adicionada:", key, "com o valor:", value)
        rawset(self, key, value)
    end,
    __metatable = false
}

return setmetatable(LucheVitae, mt)