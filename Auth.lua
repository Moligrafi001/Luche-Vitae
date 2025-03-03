local LucheVitae = setmetatable(
  {},
  {
    __newindex = function(self, key, value)
      print("Nova chave adicionada:", key, "com o valor:", value)
      rawset(self, key, value)
    end,
    __metatable = false
  }
)

return LucheVitae