-- Auth.lua

local LucheVitae = {}
LucheVitae.__index = LucheVitae

-- Armazenamento interno para configurações
local settings = {}

-- Método para configurar o serviço
function LucheVitae:Settings(config)
    settings.Service = config.Service or "DefaultService"
    print("[LucheVitae] Configurado serviço:", settings.Service)
end

-- Método para imprimir o serviço configurado
function LucheVitae:PrintService()
    if settings.Service then
        print("[LucheVitae] Serviço atual:", settings.Service)
    else
        print("[LucheVitae] Nenhum serviço configurado.")
    end
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