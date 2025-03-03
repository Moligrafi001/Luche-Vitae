local LucheVitae = {}
LucheVitae.__index = LucheVitae

local Configs = {}

-- Funções Locais
local function AdmMsg(type, msg)
  if type == 1 then
    print("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == 2 then
    warn("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == 3 then
    error("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == 9 then
    if msg == 1 then
      print(".*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.")
    elseif msg == 2 then
      warn(".*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.")
    elseif msg == 3 then
      error(".*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.")
    end
  end
end
local function d()
  if Configs.DebugMode == true then
    return true
  end
end

-- Extra
function LucheVitae:Settings(config)
  if config.Service then
    Configs.Service = config.Service
    Configs.DebugMode = config.DebugMode
    if config.KeySystem then
      Configs.KeySystem = config.KeySystem
    end
    if d() then
      AdmMsg(9, 1)
      AdmMsg(2, "DEBUG MODE IS ENABLED")
      AdmMsg(9, 1)
      AdmMsg(1, "LOADING SYSTEM...")
      AdmMsg(1, "SYSTEM STARTED SUCCESFULLY")
      AdmMsg(9, 1)
    end
  else
    AdmMsg(9, 2)
    AdmMsg(3, "MISSING SETTINGS PARAMS")
  end
end

-- Connection
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
      AdmMsg(3, "YOU ARE BANNED FROM THIS SERVICE")
      return false
    end
    if d() then
      if tipo == "Check Banned" then
        AdmMsg(1, "USER IS NOT BANNED FROM THIS SERVICE")
      elseif tipo == "Log Statistic" then
        AdmMsg(1, "STATISTIC LOGGED SUCCESFULLY")
      elseif tipo == "Send Webhook" then
        AdmMsg(1, "WEBHOOK EMBED SENT SUCCESFULLY")
      elseif tipo == "Everything" then
        AdmMsg(1, "EVERYTHING SEEMS FINE")
      else
        AdmMsg(3, "IMPLEMENT TYPE NOT SUPPORTED")
      end
    end
    return true
  end)
end

-- Key System
function LucheVitae:AuthKey(key)
  local response = request({
    Url = "http://localhost:3000/api/key?type=check&key=" .. key .. "&service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId(),
    Method = "GET"
  })
  if d() then
    AdmMsg(9, 1)
    AdmMsg(1, "CHEKING KEY... RESULT:")
  end
  if response.StatusCode == 200 then
    if d() then
      AdmMsg(1, "CHECKED KEY IS VALID")
    end
    return "valid"
  elseif response.StatusCode == 404 then
    if d() then
      AdmMsg(2, "CHECKED KEY IS INVALID")
    end
    return "invalid"
  elseif response.StatusCode == 410 then
    if d() then
      AdmMsg(2, "CHECKED KEY EXPIRED")
    end
    return "expired"
  else
    if d() then
      AdmMsg(2, "INTERNAL SERVER ERROR WHILE CHECKING THE KEY")
    end
    return false
  end
end
function LucheVitae:GetKey()
  return "http://localhost:3000/getkey/?service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId()
end

local mt = {
    __newindex = function(self, key, value)
        print("Nova chave adicionada:", key, "com o valor:", value)
        rawset(self, key, value)
    end,
    __metatable = false
}

return setmetatable(LucheVitae, mt)