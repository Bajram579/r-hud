ESX, timer, isOpen, oldMoney, oldBank, b, m = exports.es_extended:getSharedObject(), 0, false, nil, nil, 0, 0
local settings = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = false,
}

CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    Wait(500)
    Wait(1000)
    SendNUIMessage({a='vc',r=#RDEV_SH.Voice.Ranges})
    SendNUIMessage({a='sSN',name_1=RDEV_SH.Server_Name1,name_2=RDEV_SH.Server_Name2,path=RDEV_SH.Logo})
    while true do
        Wait(3000)
        if GetResourceKvpString('hudsettings') then
            settings = json.decode(GetResourceKvpString('hudsettings'))
        else
            SetResourceKvp('hudsettings', json.encode(settings))
        end
        SendNUIMessage({a='hudSettings',settings=settings,open=false})
        local acc = ESX.GetPlayerData().accounts
        for i=1, #acc, 1 do
            if acc[i].name == 'bank' then
                b = acc[i].money
            end
            if not RDEV_SH.ESX_1_1 then
                if acc[i].name == 'money' then
                    m = acc[i].money
                end
            else
                m = ESX.GetPlayerData().money
            end
        end
        checkMoney()
        local j, g = string.upper(ESX.GetPlayerData().job.label), ESX.GetPlayerData().job.grade
        SendNUIMessage({a='h',b=b,m=m,j=j,i=GetPlayerServerId(PlayerId()),g=g})
    end
end)

function checkMoney()
    if not oldMoney then oldMoney = m else
        if oldMoney > m then
            SendNUIMessage({a='mC',c='money',t='minus',m=(oldMoney-m)})
        elseif oldMoney < m then
            SendNUIMessage({a='mC',c='money',t='plus',m=(m-oldMoney)})
        end
        oldMoney = m
    end
    if not oldBank then oldBank = b else
        if oldBank > b then
            SendNUIMessage({a='mC',c='bank',t='minus',m=(oldBank-b)})
        elseif oldBank < b then
            SendNUIMessage({a='mC',c='bank',t='plus',m=(b-oldBank)})
        end
        oldBank = b
    end
end

CreateThread(function()
    while true do
        for i=1, 9, 1 do
            HideHudComponentThisFrame(i)
        end
        Wait(0)
    end
end)

CreateThread(function()
    while true do
        SendNUIMessage({a='t',t=NetworkIsPlayerTalking(PlayerId())})
        Wait(100)
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
            local weapon = GetSelectedPedWeapon(ped)
            for _, i in pairs(RDEV_SH.WeaponMap) do
                for k, v in pairs(RDEV_SH.WeaponMap[_]) do
                    if tostring(weapon) == v then
                        local __, clip = GetAmmoInClip(ped, weapon)
                        local max = GetAmmoInPedWeapon(ped, weapon) - clip
                        SendNUIMessage({a='aOn',clip=clip,max=max,weapon=k})
                    end
                end
            end
        else
            SendNUIMessage({a='aOff'})
        end
        Wait(250)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if (settings[3]) then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                sleep = 10
                local veh = GetVehiclePedIsIn(ped, false)
                local s, p, d, e, r, g = math.ceil(GetEntitySpeed(veh) * 3.6), GetVehicleFuelLevel(veh), GetVehicleDoorLockStatus(veh), GetIsVehicleEngineRunning(veh), math.ceil(GetVehicleCurrentRpm(veh) * 100), GetVehicleCurrentGear(veh)
                local _, __, l = GetVehicleLightsState(veh)
                SendNUIMessage({a='sS',s=s,p=p,d=d,e=e,l=l,r=r,g=g})
            else
                SendNUIMessage({a='hS'})
            end
        else
            SendNUIMessage({a='hS'})
        end
        Wait(sleep)
    end
end)

function helpNotifiaction(m)
    timer = GetGameTimer()
    if not isOpen then
        isOpen = true
        for _, i in pairs(RDEV_SH.StringReplaces) do
            if string.find(string.lower(m), string.lower(i.replace)) then
                m=m:gsub(i.replace, i.string)
            end
        end
        SendNUIMessage({a='sE',m=m})
        CreateThread(function()
            while timer+100 >= GetGameTimer() do Wait(100)end
            isOpen = false
            Wait(200)
            if not isOpen then
                SendNUIMessage({a='hE'})
            end
        end)
    end
end
exports('helpNotify', helpNotifiaction)

RegisterNetEvent('r-hud:announce')
AddEventHandler('r-hud:announce', function(text, time)
    SendNUIMessage({a='a',text=text,time=time})
end)

RegisterNetEvent('r-hud:start:progress')
AddEventHandler('r-hud:start:progress', function(text, time)
    SendNUIMessage({a='sP',text=text,time=time})
end)

RegisterNetEvent('r-hud:stop:progress')
AddEventHandler('r-hud:stop:progress', function()
    SendNUIMessage({a='hP'})
end)

RegisterNetEvent('r-hud:notification')
AddEventHandler('r-hud:notification', function(type, title, text, time)
    if not time then time = 3000 end
    SendNUIMessage({a='n',type=type,title=title,text=text,time=time})
end)

RegisterNetEvent('r-hud:send:players')
AddEventHandler('r-hud:send:players', function(p, mp)
    SendNUIMessage({a='p',p=p,mp=mp})
end)

RegisterCommand('hud', function()
    SetNuiFocus(true, true)
    SendNUIMessage({a='hudSettings',settings=settings,open=true})
end, false)

RegisterNUICallback('hudSetting', function(data, cb)
    settings[data.id] = data.bool
    SetResourceKvp('hudsettings', json.encode(settings))
    if data.id == 10 then
        TriggerEvent('r-hud:kinomode', data.bool)
    end
end)

RegisterNUICallback('close', function(d, cb)
    SetNuiFocus(false, false) cb('')
end)

if RDEV_SH.Voice.Handler == 'pma' then
    AddEventHandler('pma-voice:setTalkingMode', function(r)
        SendNUIMessage({a='v',r=r})
        draw(r)
    end)
    RegisterNetEvent('r-hud:set:radio')
    AddEventHandler('r-hud:set:radio', function(e)
        SendNUIMessage({a='r',e=e})
    end)
elseif RDEV_SH.Voice.Handler == 'mumble' then
    RegisterNetEvent('r-hud:send:mumble:data')
    AddEventHandler('r-hud:send:mumble:data', function(key, value)
        if key == "mode" then
            SendNUIMessage({a='v',r=value})
            draw(value)
        elseif mode == "radio" then
            if value > 0 then
                SendNUIMessage({a='r',e=true})
            else
                SendNUIMessage({a='r',e=false})
            end
        end
    end)
elseif RDEV_SH.Voice.Handler == 'salty' then
    CreateThread(function()
        while true do
            funk = exports.saltychat:GetRadioChannel(true)
            if funk ~= nil then
                SendNUIMessage({a='r',e=true})
            else
                SendNUIMessage({a='r',e=false})
            end
            Wait(200)
        end
    end)
    AddEventHandler('SaltyChat_VoiceRangeChanged', function(voiceRange, index)
        SendNUIMessage({a='v',r=index+1})
        draw(index+1)
    end)
end

function draw(r)
    local draw = true
    CreateThread(function()
        while draw do
            local pos = GetEntityCoords(PlayerPedId())
            DrawMarker(1, pos.x, pos.y, pos.z-1, 0, 0, 0, 0, 0, 0, RDEV_SH.Voice.Ranges[r], RDEV_SH.Voice.Ranges[r], 1.5, 38, 165, 140, 255, 0, 0, 0, 0)
            Wait(0)
        end
    end)
    Wait(300)
    draw = false
end