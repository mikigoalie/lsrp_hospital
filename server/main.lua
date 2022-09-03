ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('lsrp_hos:canPay', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local moni = xPlayer.getAccount('money').money
    local banka = xPlayer.getAccount('bank').money
    if moni >= price then
        xPlayer.removeMoney(price)
        cb(true)
    elseif moni < price and banka >= price then
        xPlayer.removeAccountMoney('bank', price)
        cb(true)
    else
        cb(false)
    end
end)

--[[ESX.RegisterServerCallback('lsrp_hos:canPay2', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local moni = xPlayer.getAccount('money').money
    local banka = xPlayer.getAccount('bank').money

    if moni >= price then
        xPlayer.removeMoney(price)
        cb(true)
    elseif moni < price and banka >= price then
        xPlayer.removeAccountMoney('bank', price)
        cb(true)
    else
        cb(false)
    end
end)]] -- Useless shit for other script of mine, u can delete this

ESX.RegisterServerCallback('lsrp_hos:checkDeath', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ide = xPlayer.identifier
    print(ide)
    MySQL.single('SELECT is_dead FROM users WHERE identifier = ?', { ide }, function(row)
        if row.is_dead then cb(true) else cb(false) end
    end)
end)


ESX.RegisterServerCallback('lsrp_hos:checkEMS', function(source, cb, emsRequired)
    local xPlayers = ESX.GetExtendedPlayers('job', Config.EMSJobName)
    if #xPlayers >= Config.EMSRequired then
        cb(true)
    else
        cb(false)
    end
end)
