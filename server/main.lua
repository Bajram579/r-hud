ESX = exports.es_extended:getSharedObject()
loadedCode = {}

CreateThread(function()
    while true do
        Wait(1500)
        TriggerClientEvent('r-hud:send:players', -1, GetNumPlayerIndices(), GetConvarInt('sv_maxclients', 'ERROR'))
    end
end)

if RDEV_SH.Voice.Handler == 'mumble' then
    RegisterNetEvent('mumble:SetVoiceData')
    AddEventHandler('mumble:SetVoiceData', function(key, value)
        TriggerClientEvent('r-hud:send:mumble:data', source, key, value)
    end)
end

RegisterCommand('announce', function(s, args)
    local group = ESX.GetPlayerFromId(s).getGroup()
    for _, i in pairs(RDEV_SH.AllowedGroups) do
        if group == i then
            local msg = table.concat(args, " ", 1, #args)
            TriggerClientEvent('r-hud:announce', -1, GetPlayerName(s)..': '..msg, 10000)
            break
        end
    end
end, false)