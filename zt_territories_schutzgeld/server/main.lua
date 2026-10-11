local function getPlayer(src)
    if Config.Core == 'qbx' then
        return exports.qbx_core:GetPlayer(src)
    elseif Config.Core == 'qb' then
        return exports['qb-core']:GetCoreObject().Functions.GetPlayer(src)
    elseif Config.Core == 'esx' then
        return exports['es_extended']:getSharedObject().GetPlayerFromId(src)
    end
    return nil
end

local function getPlayerGang(player)
    if Config.Core == 'qbx' or Config.Core == 'qb' then
        return player.PlayerData.gang.name
    elseif Config.Core == 'esx' then
        return player.job.name
    end
    return nil
end

local function addMoney(src, player, amount)
    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:AddItem(src, 'black_money', amount)
    else
        if Config.Core == 'qbx' or Config.Core == 'qb' then
            player.Functions.AddMoney('crypto', amount)
        elseif Config.Core == 'esx' then
            player.addAccountMoney('black_money', amount)
        end
    end
end

lib.callback.register('zt_territories:server:getShopStatus', function(source, shopId)
    local row = MySQL.single.await('SELECT * FROM zt_protection_contracts WHERE shop_id = ?', { shopId })
    if not row then
        local base = Config.Shops[shopId]
        if not base then return nil end
        MySQL.insert.await('INSERT INTO zt_protection_contracts (shop_id, zone_id, shop_label, gang_name, current_pot) VALUES (?, ?, ?, ?, ?)', {
            shopId, base.zone, base.label, 'none', 0
        })
        return { gang = 'none', pot = 0 }
    end
    return { gang = row.gang_name, pot = row.current_pot }
end)

RegisterNetEvent('zt_territories:server:claimShop', function(shopId)
    local src = source
    local player = getPlayer(src)
    if not player then return end

    local gang = getPlayerGang(player)
    if not Config.AuthorizedGangs[gang] then return end

    MySQL.update('UPDATE zt_protection_contracts SET gang_name = ? WHERE shop_id = ?', { gang, shopId }, function(affected)
        if affected > 0 then
            TriggerClientEvent('ox_lib:notify', src, { title = 'Revier', description = 'Vertrag erfolgreich ueberschrieben.', type = 'success' })
        end
    end)
end)

RegisterNetEvent('zt_territories:server:collectPot', function(shopId)
    local src = source
    local player = getPlayer(src)
    if not player then return end

    local gang = getPlayerGang(player)
    local row = MySQL.single.await('SELECT * FROM zt_protection_contracts WHERE shop_id = ?', { shopId })
    if not row or row.gang_name ~= gang then return end

    local amount = row.current_pot
    if amount <= 0 then
        TriggerClientEvent('ox_lib:notify', src, { title = 'Depot', description = 'Kein Ertrag vorhanden.', type = 'error' })
        return
    end

    MySQL.update('UPDATE zt_protection_contracts SET current_pot = 0, last_payout = NOW() WHERE shop_id = ?', { shopId }, function()
        addMoney(src, player, amount)
        TriggerClientEvent('ox_lib:notify', src, { title = 'Depot', description = ('Ertrag entnommen: $%s'):format(amount), type = 'success' })
    end)
end)

CreateThread(function()
    while true do
        Wait(Config.TickInterval)
        for shopId, data in pairs(Config.Shops) do
            MySQL.update('UPDATE zt_protection_contracts SET current_pot = current_pot + ? WHERE shop_id = ? AND gang_name != "none"', {
                data.rate, shopId
            })
        end
    end
end)
