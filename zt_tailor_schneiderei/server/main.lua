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

local function getCitizenId(player)
    if Config.Core == 'qbx' or Config.Core == 'qb' then
        return player.PlayerData.citizenid
    elseif Config.Core == 'esx' then
        return player.identifier
    end
    return nil
end

RegisterNetEvent('zt_tailor:server:saveAdjustment', function(componentId, drawableId, textureId)
    local src = source
    local player = getPlayer(src)
    if not player then return end

    local cid = getCitizenId(player)
    if not cid then return end

    MySQL.insert([[
        INSERT INTO zt_tailor_modifications (citizenid, component_id, drawable_id, texture_id)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE drawable_id = VALUES(drawable_id), texture_id = VALUES(texture_id)
    ]], { cid, componentId, drawableId, textureId }, function()
        TriggerClientEvent('ox_lib:notify', src, { title = 'Schneiderei', description = 'Aenderung am Kleidungsstueck gespeichert.', type = 'success' })
    end)
end)
