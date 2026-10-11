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

RegisterNetEvent('zt_drivingschool:server:evaluateTheory', function(passed)
    local src = source
    local player = getPlayer(src)
    if not player then return end

    local cid = getCitizenId(player)
    if not cid then return end

    if passed then
        MySQL.insert('INSERT INTO zt_driving_licenses (citizenid, theory_passed) VALUES (?, 1) ON DUPLICATE KEY UPDATE theory_passed = 1', { cid }, function()
            TriggerClientEvent('ox_lib:notify', src, { title = 'Fahrschule', description = 'Theoriepruefung bestanden!', type = 'success' })
        end)
    else
        TriggerClientEvent('ox_lib:notify', src, { title = 'Fahrschule', description = 'Theoriepruefung nicht bestanden.', type = 'error' })
    end
end)

RegisterNetEvent('zt_drivingschool:server:passPractical', function(targetSrc)
    local src = source
    local instructor = getPlayer(src)
    if not instructor then return end

    local instructorJob = (instructor.PlayerData and instructor.PlayerData.job and instructor.PlayerData.job.name) or (instructor.job and instructor.job.name)
    if instructorJob ~= Config.InstructorJob then return end

    local student = getPlayer(targetSrc)
    if not student then return end

    local studentCid = getCitizenId(student)
    local instructorCid = getCitizenId(instructor)

    MySQL.update('UPDATE zt_driving_licenses SET practical_passed = 1, instructor_id = ? WHERE citizenid = ?', { instructorCid, studentCid }, function(affected)
        if affected > 0 then
            TriggerClientEvent('ox_lib:notify', targetSrc, { title = 'Fahrschule', description = 'Praktische Pruefung bestanden! Fuehrerschein erhalten.', type = 'success' })
            TriggerClientEvent('ox_lib:notify', src, { title = 'Fahrschule', description = 'Pruefung erfolgreich abgenommen.', type = 'success' })
        end
    end)
end)
