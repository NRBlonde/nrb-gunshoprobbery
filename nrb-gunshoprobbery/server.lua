ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('nrb:itemcheck', function(source, cb , itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(itemname).count
    if count >= 1  then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('nrb-soygun:kartver')
AddEventHandler('nrb-soygun:kartver', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("soygunkart", 1)
end)

ESX.RegisterServerCallback('nrb-soygun:meslekkontrol', function(source, cb , jobname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name

    if job == 'police' or job == 'ambulance' then
        cb(false)
    else
        cb(true)
    end
end)

RegisterServerEvent('nrb-soygun:kutuver')
AddEventHandler('nrb-soygun:kutuver', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local number = math.random(1,4)
								
    if number == 1 then
        xPlayer.addInventoryItem('WEAPON_SWITCHBLADE', 1)
    elseif number == 2 then
        xPlayer.addInventoryItem('water', 1)
        
    elseif number == 3 then
        xPlayer.addInventoryItem('bread', 1)
    elseif number == 4 then
        xPlayer.addInventoryItem('lockpick', 1)
    end
end)

RegisterServerEvent('nrb-soygun:kartsil')
AddEventHandler('nrb-soygun:kartsil', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("soygunkart", 1)
end)

ESX.RegisterServerCallback('nrb-soygun:kasakontrol', function(source, cb , itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(itemname).count
    if count >= 1  then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('nrb-soygun:kasaanahtarsil')
AddEventHandler('nrb-soygun:kasaanahtarsil', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("kasaanahtar", 1)
end)
