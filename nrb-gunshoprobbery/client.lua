ESX = nil
PlayerData = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(4) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 215) AddTextComponentString(text) DrawText(_x, _y) local factor = (string.len(text)) / 700 DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100) end

local locked = true

function KasaSoy()
    TriggerServerEvent("nrb-soygun:kasaanahtarsil")
    local ped = PlayerPedId()
    TriggerServerEvent('m3:dispatch:notify', 'Silahçı Soygun İhbarı', 'Anonim', 'Yok', GetEntityCoords(ped))
    local finished = exports["reload-skillbar"]:taskBar(1000,math.random(5,10))
    if finished ~= 100 then
        exports['mythic_notify']:SendAlert('error', 'Başarısız Oldun!', 3000)
    else
    Citizen.Wait(1000)
    TriggerServerEvent("nrb-soygun:kasaanahtarsil")
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 25000, --25 saniye
        label = "Kasa Açılıyor",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mini@repair",
            anim = "fixing_a_ped",
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            print("sa")
        end
    end)
    Citizen.Wait(25000)
    exports['mythic_notify']:SendAlert('success', 'Kasayı Açtın!', 3000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent("nrb-soygun:kartver")
    end
end

function KasaAra()
    --    TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)	
        TriggerEvent("mythic_progbar:client:progress", {
          name = "unique_action_name",
          duration = 180000, --180 saniye
          label = "Kasa Aranıyor",
          useWhileDead = false,
          canCancel = true,
          controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
          },
          animation = {
              animDict = "mini@repair",
              anim = "fixing_a_ped",
          },
          prop = {
              model = "prop_paper_bag_small",
          }
      }, function(status)
          if not status then
              print("sa")
          end
      end)
        Citizen.Wait(180000) --180 Saniye
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('nrb-soygun:kutuver')
end

Citizen.CreateThread(function()
while true do
    local sleep = 1500
 if PlayerData.job ~= nil then
    local job = PlayerData.job.name
    local player = PlayerPedId()
    local playercoords = GetEntityCoords(player)
    local dst = GetDistanceBetweenCoords(playercoords, 23.6631, -1106.4, 29.9791, true) --23.6631, -1106.4, 29.9791
--    local kasacoords = GetEntityCoords(kasa)
--    local coords = GetEntityCoords(PlayerPedId())   
--    local dst = #(coords - kasacoords)
    if dst <= 2 then
      DrawText3D(23.6631, -1106.4, 29.9791, "~r~[E]~r~ ~w~- Soy~w~", 0.40)
      sleep = 1 
      if IsControlJustReleased(0,46) then
          ESX.TriggerServerCallback('nrb-soygun:meslekkontrol', function(controlmeslek)
              if controlmeslek then
                ESX.TriggerServerCallback('nrb-soygun:kasakontrol', function(kasakontrollen)
                    if kasakontrollen then
                        if IsPedArmed(PlayerPedId(), 7) then
                  KasaSoy()
              else
                  exports['mythic_notify']:SendAlert('error', 'Soygun Yapamassın!', 3000)
                        end
                    end
                end, "kasaanahtar")
              end
          end)
       end
    end
 end

local door = GetClosestObjectOfType(134.495, -2203.4, 7.18757, 2.0, GetHashKey("v_ilev_tort_door"), false, false, false)
local doorcords = GetEntityCoords(door)
local coords = GetEntityCoords(PlayerPedId())
local dst2 = #(coords - doorcords)
if dst2 <= 2 then
    if locked then
        sleep = 7
        SetEntityHeading(door,270.0)
        FreezeEntityPosition(door,true)
        DrawText3D(134.495, -2203.4, 7.18757, "~r~[E]~r~ ~w~- Kilitli~w~", 0.40)
        else
        DrawText3D(134.495, -2203.4, 7.18757, "~r~[E] ~r~ ~w~- Açık~w~", 0.40)
    end
    sleep = 0 
    if IsControlJustReleased(0,46) then
        ESX.TriggerServerCallback('nrb:itemcheck', function(control)
            if control then
                FreezeEntityPosition(door,false)
                locked = not locked
                TriggerServerEvent('nrb-soygun:kartsil')
            else
                exports['mythic_notify']:SendAlert('error', 'Üzerinde Anahtar Yok!')
            end
            if not locked then
              Citizen.Wait(90000)
              locked = true
            end
        end, "soygunkart")
    end
end

local player = PlayerPedId()
local playercoords = GetEntityCoords(player)
local silaharama = GetDistanceBetweenCoords(playercoords, 144.949, -2204.1, 4.68802, true)

if silaharama <= 2 then
  sleep = 1
  DrawText3D(144.949, -2204.1, 4.68802, "~r~[E]~r~ ~w~- Kasa Ara~w~", 0.40)
end

if silaharama <= 2 then
  if IsControlJustReleased(0,46) then
    KasaAra()
  end  
end

    Citizen.Wait(sleep)
end    
end)

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
  end
