local LucheVitae = setmetatable(
  {},
  {
    __newindex = function(self, key)
      return rawget(self, key)
    end,
    __metatable = false
  }
)

return LucheVitae
