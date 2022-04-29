vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_slot_machine")

Citizen.CreateThread(function()
    while true do 
        DrawMarker(1, 309.60040283203,-585.98461914062,43.284061431885-1, 0, 0, 0, 0, 0, 0, 1.7, 1.7, 0.5, 0, 255, 125, 125, 0, 0, 0, 0, 0, 0, 0)
        DrawMarker(1, 167.48913574219,-903.79858398438,31.328386306763-1, 0, 0, 0, 0, 0, 0, 1.7, 1.7, 0.5, 0, 255, 125, 125, 0, 0, 0, 0, 0, 0, 0)
        if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),309.60040283203,-585.98461914062,43.284061431885, true) <= 1) then
            if IsControlJustPressed(1, 38) then
                TriggerServerEvent("vrp_slot_machine:menu")
            end
        end
        if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),167.48913574219,-903.79858398438,31.328386306763, true) <= 1) then
            if IsControlJustPressed(1, 38) then
                TriggerServerEvent("vrp_slot_machine:menu2")
            end
        end
        Wait(0)
    end
end)