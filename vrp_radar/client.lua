--===============================================--===============================================
--= stationary radars https://github.com/DreanorGTA5Mods/StationaryRadar				 	     =
--===============================================--===============================================
-- ###################################
--
--       Credits: Sighmir and Shadow
--
-- ###################################
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
RDserver = Tunnel.getInterface("vrp_radar")

local radares = {
{x = 379.68807983398, y = -1048.3527832031, z = 29.250692367554},
{x = 379.68807983398, y = 1048.3527832031, z = 29.250692367554},
-- Novos radares
{x = 195.64338684082, y = -593.70587158203, z = 29.429971694946},
{x = 193.45606994629, y = -598.97595214844, z = 29.456104278564},
{x = -57.526218414307, y = -493.75201416016, z = 40.389003753662},
{x = -52.073360443115, y = -495.46966552734, z = 40.46549987793},
{x = -46.02758026123, y = -497.51147460938, z = 40.465480804443},
{x = -41.624404907227, y = -498.86831665039, z = 40.46556854248},
{x = -37.564472198486, y = -500.3854675293, z = 40.391532897949},
{x = 109.90229797363, y = -526.70617675781, z = 43.19242477417},
{x = 116.30445098877, y = -529.05200195313, z = 43.23454284668},
{x = 122.64904022217, y = -531.42083740234, z = 43.218902587891},
{x = 128.94078063965, y = -533.67102050781, z = 43.269691467285},
{x = 208.24230957031, y = -1027.0505371094, z = 29.372922897339},
{x = 206.45935058594, y = -1031.7166748047, z = 29.370674133301},
{x = 204.48260498047, y = -1036.9130859375, z = 29.372924804688},
{x = 202.45922851563, y = -1042.2276611328, z = 29.349960327148},
----------------------------------------------------------------
{x = -998.0586, y = -2447.498, z = 20.139},
{x = -993.938, y = -2450.033, z = 20.183},
----------------------------------------------------------------
{x = -818.195, y = -2559.237, z = 13.756},
----------------------------------------------------------------
{x = -95.516, y = -1305.999, z = 29.281},
{x = -100.421, y = -1305.937, z = 29.349},
{x = -106.089, y = -1305.923, z = 29.348},
{x = -110.842, y = -1305.876, z = 29.306},
-----------------------------------------------------------------
{x = 66.402, y = -1321.562, z = 29.252},
{x = 71.089, y = -1318.886, z = 29.343},
{x = 80.084, y = -1313.637, z = 29.342},
{x = 84.903, y = -1310.826, z = 29.288},
-----------------------------------------------------------------
{x = 311.225, y = -1491.348, z = 29.249},
{x = 307.048, y = -1494.972, z = 29.340},
{x = 303.376, y = -1498.153, z = 29.305},
{x = 298.790, y = -1502.127, z = 29.254}
}

-- 379.68807983398,-1048.3527832031,29.250692367554
-- 195.64338684082,-593.70587158203,29.429971694946
-- 193.45606994629,-598.97595214844,29.456104278564
-- -57.526218414307,-493.75201416016,40.389003753662
-- -52.073360443115,-495.46966552734,40.46549987793
-- -46.02758026123,-497.51147460938,40.465480804443
-- -41.624404907227,-498.86831665039,40.46556854248
-- -37.564472198486,-500.3854675293,40.391532897949
-- 109.90229797363,-526.70617675781,43.19242477417
-- 116.30445098877,-529.05200195313,43.23454284668
-- 122.64904022217,-531.42083740234,43.218902587891
-- 128.94078063965,-533.67102050781,43.269691467285
-- 208.24230957031,-1027.0505371094,29.372922897339
-- 206.45935058594,-1031.7166748047,29.370674133301
-- 204.48260498047,-1036.9130859375,29.372924804688
-- 202.45922851563,-1042.2276611328,29.349960327148


Citizen.CreateThread(function()
  while true do
    Wait(0)
	for k,v in pairs(radares) do
	pP = GetPlayerPed(-1)
	local coords = GetEntityCoords(pP, true)
	if Vdist2(v.x, v.y, v.z, coords["x"], coords["y"], coords["z"]) < 10 then
		checkSpeed()
	end
  end
 end
end)

function checkSpeed()
    local speed = GetEntitySpeed(pP)
    local vehicle = GetVehiclePedIsIn(pP, false)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local maxspeed = 80
    local kmhspeed = math.ceil(speed*3.6)
    if kmhspeed > maxspeed and driver == pP then
        Citizen.Wait(250)
        if not RDserver.checkPerm() then
            TriggerServerEvent('cobrarMulta')
            TriggerEvent("pNotify:SendNotification",{text = "<b style='color:#FFFF'>Radar</b> <br /><br />Você foi multado por acelerar.<br/>Valor da Multa: R$150<br/>Limite de velocidade: 60km/h<br/>Sua velocidade: " ..kmhspeed .. "km/h <br/>", type = "info", timeout = (5000),layout = "centerLeft"})
        end
    end
end