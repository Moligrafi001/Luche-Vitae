local LucheVitae = {}
LucheVitae.__index = LucheVitae

local Configs = {}

local function AdmMsg(type, msg)
  if type == p then
    print("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == w then
    warn("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == e then
    error("[ Luche Vitae ] - " .. tostring(msg))
  end
end

function LucheVitae:PrintService()
  AdmMsg(p, "YOUR SERVICE IS: " .. Configs.Service)
end

function LucheVitae:Settings(config)
  if config.Service and config.DebugMode then
    Configs.Service = config.Service
    Configs.DebugMode = config.DebugMode
    if config.KeySystem then
      Configs.KeySystem = config.KeySystem
    end
    if config.DebugMode == true then
      AdmMsg(w, "DEBUG MODE IS ENABLED")
      AdmMsg(p, "SYSTEM STARTED SUCCESFULLY")
    end
  else
    AdmMsg(e, "MISSING PARAMS IN UR SETTINGS")
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
      Url = "http://localhost:3000/api/integrity",
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
      return
    end
    if Configs.DebugMode == true then
      if tipo == "Check Banned" or tipo == "Everything" then
        AdmMsg(P, "USER IS NOT BANNED FROM THIS SERVICE")
      elseif tipo == "Log Statistic" or tipo == "Everything" then
        AdmMsg(p, "STATISTIC LOGGED SUCCESFULLY")
      elseif tipo == "Log Statistic" or tipo == "Everything" then
        AdmMsg(p, "WEBHOOK EMBED SENT SUCCESFULLY")
      elseif tipo == "Log Statistic" or tipo == "Everything" then
        AdmMsg(p, "WEBHOOK EMBED SENT SUCCESFULLY")
      else
        AdmMsg(e, "IMPLEMENT TYPE NOT SUPPORTED")
      end
    end
  end)
end

function LucheVitae:GetKey()
  return "http://localhost:3000/getkey/?service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId()
end

function LucheVitae:AuthKey(key)
  local response = request({
    Url = "http://localhost:3000/api/key?type=check&key=" .. key .. "&service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId(),
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
