local LucheVitae = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Luche-Vitae/refs/heads/main/Auth.lua"))() -- Load the Library

LucheVitae:Settings({ -- Load your settings
  Service = "hallowhub", -- Your service identificator
  DebugMode = true, -- Debug things in console
  
  KeySystem = { -- Delete this if you're not using the key system
    GuiMode = true, -- Simple GUI to the key
    SaveKey = true -- Save valid key
  }
})

-- Key System Functions
local function ValidateKey(key) -- Your own custom function to check the key
  if LucheVitae:AuthKey(key) == "valid" then -- If key is valid
    print("Key is valid, loading...") -- Valid notification
  elseif LucheVitae:AuthKey(key) == "invalid" then -- If key is invalid
    print("Key is invalid!") -- Invalid notification
  elseif LucheVitae:AuthKey(key) == "expired" then -- If key expired
    print("Key expired!") -- Expired notification
  else -- If authentication failed
    print("Failed to check the key.") -- Failed to check key notification
  end -- Add your own actions
end
local function GetKey() -- Your own custom function to get key
  setclipboard(LucheVitae:GetKey()) -- Will copy the get key url
end

-- Implementation Functions
LucheVitae:Implement("Log Statistic") -- Log this execution statistics
LucheVitae:Implement("Check Banned") -- Check if the user is banned
LucheVitae:Implement("Send webhook") -- Send webhook embed
LucheVitae:Implement("Everything") -- Will do the same as the 3 above