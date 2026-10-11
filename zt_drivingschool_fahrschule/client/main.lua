local isInstructor = false
local brakeActive = false

local function checkInstructorSeat()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if not veh or veh == 0 then
        isInstructor = false
        brakeActive = false
        return
    end

    local seat = GetPedInVehicleSeat(veh, 0)
    if seat == ped then
        local pData = nil
        if Config.Core == 'qbx' then
            pData = exports.qbx_core:GetPlayerData()
        elseif Config.Core == 'qb' then
            pData = exports['qb-core']:GetCoreObject().Functions.GetPlayerData()
        elseif Config.Core == 'esx' then
            pData = exports['es_extended']:getSharedObject().GetPlayerData()
        end

        local jobName = (pData and pData.job and pData.job.name) or ''
        isInstructor = (jobName == Config.InstructorJob)
    else
        isInstructor = false
        brakeActive = false
    end
end

CreateThread(function()
    while true do
        Wait(1000)
        checkInstructorSeat()
    end
end)

RegisterCommand('+ztInstructorBrake', function()
    if not isInstructor then return end
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if not veh or veh == 0 then return end

    brakeActive = true
    lib.notify({ title = 'Fahrschule', description = 'Doppelpedal-Notbremse aktiviert.', type = 'warning' })

    CreateThread(function()
        while brakeActive do
            SetVehicleForwardSpeed(veh, 0.0)
            SetVehicleHandbrake(veh, true)
            Wait(0)
        end
        SetVehicleHandbrake(veh, false)
    end)
end, false)

RegisterCommand('-ztInstructorBrake', function()
    brakeActive = false
end, false)

RegisterKeyMapping('+ztInstructorBrake', 'Fahrlehrer Notbremse', 'keyboard', Config.BrakeKey)

local function openTheoryNUI()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openTheory',
        questions = Config.TheoryQuestions
    })
end

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('submitTheory', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent('zt_drivingschool:server:evaluateTheory', data.passed)
    cb('ok')
end)

CreateThread(function()
    exports.ox_target:addSphereZone({
        coords = Config.SchoolLocation,
        radius = 1.5,
        options = {
            {
                name = 'driving_theory_test',
                label = 'Theoriepruefung ablegen',
                icon = 'fas fa-graduation-cap',
                onSelect = function()
                    openTheoryNUI()
                end
            }
        }
    })
end)
