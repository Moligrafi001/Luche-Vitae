local LucheVitae = {}
LucheVitae.__index = LucheVitae

local Configs = {}

function LucheVitae:PrintService()
  print(Configs.Service)
end

function LucheVitae:Settings(config)
  if config.Service and config.DebugMode then
    Configs.Service = config.Service
    Configs.DebugMode = config.DebugMode
    if config.KeySystem then
      Configs.KeySystem = config.KeySystem
    end
    if config.DebugMode == true then
      print("[ Luche Vitae ] - SERVICE STARTED SUCCESFULLY")
    end
  else
    error("[ Luche Vitae ] - MISSING PARAMS IN UR SETTINGS")
  end
end

function LucheVitae:Implement(tipo)
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
      Url = "https://orange-auth.squareweb.app/api/integrity",
      Method = "POST",
      Headers = {
        ["type"] = tostring(tipo),
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
  
    if not response or ((tipo == "Check Banned" or tipo == "Everything") and response.StatusCode == 401) then
      game:GetService("Players").LocalPlayer:Kick("\n\nYou are permanently banned from this service, don't try to bypass this\n\nProvided by Luche Vitae ™")
    end
  end)
end

function LucheVitae:GetKey()
  return "https://orange-auth.squareweb.app/getkey/?service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId()
end

function LucheVitae:AuthKey(key)
  local response = request({
    Url = "https://orange-auth.squareweb.app/api/key?type=check&key=" .. key .. "&service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId(),
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

local mt = {
    __newindex = function(self, key, value)
        print("Nova chave adicionada:", key, "com o valor:", value)
        rawset(self, key, value)
    end,
    __metatable = false
}

return setmetatable(LucheVitae, mt)
