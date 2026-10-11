local function getPlayerData()
    if Config.Core == 'qbx' then
        return exports.qbx_core:GetPlayerData()
    elseif Config.Core == 'qb' then
        return exports['qb-core']:GetCoreObject().Functions.GetPlayerData()
    elseif Config.Core == 'esx' then
        return exports['es_extended']:getSharedObject().GetPlayerData()
    end
    return nil
end

local function openShopMenu(shopId, shopData)
    local pData = getPlayerData()
    if not pData then return end

    local gangName = (pData.gang and pData.gang.name) or (pData.job and pData.job.name)
    if not Config.AuthorizedGangs[gangName] then
        lib.notify({ title = 'Revier', description = 'Du gehoerst keiner autorisierten Fraktion an.', type = 'error' })
        return
    end

    lib.callback('zt_territories:server:getShopStatus', false, function(status)
        if not status then return end

        local options = {
            {
                title = 'Status einsehen',
                description = ('Kontrollierende Gang: %s | Depot: $%s'):format(status.gang or 'Niemand', status.pot or 0),
                icon = 'shield'
            }
        }

        if status.gang == gangName then
            table.insert(options, {
                title = 'Schutzgeld einsammeln',
                description = ('Aktueller Ertrag: $%s'):format(status.pot),
                icon = 'sack-dollar',
                onSelect = function()
                    TriggerServerEvent('zt_territories:server:collectPot', shopId)
                end
            })
        else
            table.insert(options, {
                title = 'Schutzvertrag erzwingen',
                description = 'Dieses Geschaeft unter deinen Schutz stellen',
                icon = 'handshake',
                onSelect = function()
                    TriggerServerEvent('zt_territories:server:claimShop', shopId)
                end
            })
        end

        lib.registerContext({
            id = 'shop_protection_' .. shopId,
            title = shopData.label,
            options = options
        })
        lib.showContext('shop_protection_' .. shopId)
    end, shopId)
end

CreateThread(function()
    for shopId, shopData in pairs(Config.Shops) do
        exports.ox_target:addSphereZone({
            coords = shopData.coords,
            radius = 1.2,
            options = {
                {
                    name = 'protect_' .. shopId,
                    label = 'Schutzgeld & Revier verwalten',
                    icon = 'fas fa-sack-dollar',
                    onSelect = function()
                        openShopMenu(shopId, shopData)
                    end
                }
            }
        })
    end
end)
