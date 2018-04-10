-- ###################################
--
--       Credits: Sighmir and Shadow
--
-- ###################################
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPrd = {}
Tunnel.bindInterface("vrp_radar",vRPrd)

RegisterServerEvent('cobrarMulta')
AddEventHandler('cobrarMulta', function()
    local user_id = vRP.getUserId(source)
    local multas = vRP.getUData(user_id,"multas")
    if multas == "" then multas = 0 else multas = tonumber(multas) end
    vRP.insertPoliceRecord(user_id, "Excesso de Velocidade")
    vRP.setUData(user_id,"multas",multas+150)
end)

function vRPrd.checkPerm()
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "naotoma.multa")
end