local LucheVitae = {}
LucheVitae.__index = LucheVitae

local Configs = {}

-- Funções Locais
local function AdmMsg(type, msg)
  if type == p then
    print("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == w then
    warn("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == e then
    error("[ Luche Vitae ] - " .. tostring(msg))
  elseif type == 9 then
    if msg == p then
      print(".*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.")
    elseif msg == w then
      warn(".*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.")
    elseif msg == e then
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
      AdmMsg(9, p)
      AdmMsg(w, "DEBUG MODE IS ENABLED")
      AdmMsg(9, p)
      AdmMsg(p, "LOADING SYSTEM...")
      AdmMsg(p, "SYSTEM STARTED SUCCESFULLY")
      AdmMsg(9, p)
    end
  else
    AdmMsg(9, w)
    AdmMsg(e, "MISSING SETTINGS PARAMS")
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
      AdmMsg(e, "YOU ARE BANNED FROM THIS SERVICE")
    end
    if d() then
      if tipo == "Check Banned" then
        AdmMsg(P, "USER IS NOT BANNED FROM THIS SERVICE")
      elseif tipo == "Log Statistic" then
        AdmMsg(p, "STATISTIC LOGGED SUCCESFULLY")
      elseif tipo == "Send Webhook" then
        AdmMsg(p, "WEBHOOK EMBED SENT SUCCESFULLY")
      elseif tipo == "Everything" then
        AdmMsg(p, "EVERYTHING SEEMS FINE")
      else
        AdmMsg(e, "IMPLEMENT TYPE NOT SUPPORTED")
      end
    end
  end)
end

-- Key System
function LucheVitae:AuthKey(key)
  local response = request({
    Url = "http://localhost:3000/api/key?type=check&key=" .. key .. "&service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId(),
    Method = "GET"
  })
  if d() then
    AdmMsg(9, p)
    AdmMsg(p, "CHEKING KEY... RESULT:")
  end
  if response.StatusCode == 200 then
    if d() then
      AdmMsg(p, "CHECKED KEY IS VALID")
    end
    return "valid"
  elseif response.StatusCode == 404 then
    if d() then
      AdmMsg(w, "CHECKED KEY IS INVALID")
    end
    return "invalid"
  elseif response.StatusCode == 410 then
    if d() then
      AdmMsg(w, "CHECKED KEY EXPIRED")
    end
    return "expired"
  else
    if d() then
      AdmMsg(w, "INTERNAL SERVER ERROR WHILE CHECKING THE KEY")
    end
    return false
  end
end
function LucheVitae:GetKey()
  return "http://localhost:3000/getkey/?service=" .. Configs.Service .. "&id=" .. game:GetService("RbxAnalyticsService"):GetClientId()
end

AdmMsg(9, p)

local mt = {
    __newindex = function(self, key, value)
        print("Nova chave adicionada:", key, "com o valor:", value)
        rawset(self, key, value)
    end,
    __metatable = false
}

return setmetatable(LucheVitae, mt)