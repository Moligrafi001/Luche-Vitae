## Luche Vitae Library

Welcome! This tutorial explains how to use the **Luche Vitae Library**. This powerful library is designed for authentication and implementing functionalities within your script, adding more server side to your client. Each section below breaks down how to load, configure, and utilize the library's key features.

---

## 1. Loading the Library

First, load the library directly from GitHub using `loadstring` combined with `game:HttpGet`, which retrieves and executes the remote code.

```lua
local LucheVitae = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Luche-Vitae/refs/heads/main/Auth.lua"))() -- Load the Library
```

## 2. Initializing Settings

After you set up the the library you'll have to set your settings below. Don't forget to add a valid service in the `Service` section.

```lua
LucheVitae:Settings({ -- Load your settings
  Service = "hallowhub", -- Your service identificator
  DebugMode = true, -- Debug things in console
  
  KeySystem = { -- Delete this if you're not using the key system
    GuiMode = true, -- Simple GUI to the key
    SaveKey = true -- Save valid key
  }
})
```

## 3. Implementation Functions

These are the codes to implement and connect your functions to your service, you can `Log Statistic`, `Check Banned`, `Send Webhook` and use `Everything` to do the same as the 3 other ones.

```lua
-- Implementation Functions
LucheVitae:Implement("Log Statistic") -- Log this execution statistics
LucheVitae:Implement("Check Banned") -- Check if the user is banned
LucheVitae:Implement("Send Webhook") -- Send webhook embed
LucheVitae:Implement("Everything") -- Will do the same as the 3 above
```

> The implementation has a 30s cooldown to avoid spammers

## Final Example Code

This is a exemple code, you can customize it the way you want, fell free to add and customize your own functions.

```lua
local LucheVitae = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Luche-Vitae/refs/heads/main/Source/Library.lua"))() -- Load the Library

LucheVitae:Settings({ -- Load your settings
  Service = "yourservice", -- Your service identificator
  DebugMode = true, -- Debug things in console
  
  KeySystem = { -- Delete this if you're not using the key system
    GuiMode = true, -- Simple GUI to the key
    SaveKey = true -- Save valid key
  }
})

if not LucheVitae:Implement("Check Banned") then return end -- Will stop the script if the user is banned

-- Key System Functions
local function ValidateKey(key) -- Your own custom function to check the key
  if LucheVitae:AuthKey(key) == "valid" then -- If key is valid
    print("Key is valid, loading...") -- Valid notification
    -- If the user isn't banned and the key is valid
    return true
  elseif LucheVitae:AuthKey(key) == "expired" then -- If key expired
    print("Key expired!") -- Expired notification
  elseif LucheVitae:AuthKey(key) == "invalid" then -- If key is invalid
    print("Key is invalid!") -- Invalid notification
  else -- If authentication failed
    print("Failed to check the key.") -- Failed to check key notification
  end -- Add your own actions
  return false
end
local function GetKey() -- Your own custom function to get key
  setclipboard(LucheVitae:GetKey()) -- Will copy the get key url
end

if ValidateKey("YOUR-KEY-HERE") then
  LucheVitae:Implement("Send Webhook") -- Send webhook embed
  LucheVitae:Implement("Log Statistic") -- Log this execution Statistic
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() -- Will execute infiniteyield
else
  GetKey()
end
```
