local activeCam = nil

local function destroyFittingCam()
    if activeCam then
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(activeCam, false)
        activeCam = nil
    end
end

local function createFittingCam(boneIndex)
    destroyFittingCam()
    local ped = PlayerPedId()
    local boneCoords = GetPedBoneCoords(ped, boneIndex, 0.0, 0.0, 0.0)
    local fwd = GetEntityForwardVector(ped)
    local camCoords = boneCoords + (fwd * 1.1) + vector3(0.0, 0.0, 0.05)

    activeCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(activeCam, camCoords.x, camCoords.y, camCoords.z)
    PointCamAtCoord(activeCam, boneCoords.x, boneCoords.y, boneCoords.z)
    SetCamActive(activeCam, true)
    RenderScriptCams(true, true, 500, true, true)
end

local function openTorsoTuning()
    local ped = PlayerPedId()
    createFittingCam(24818)

    local currentDraw = GetPedDrawableVariation(ped, 11)
    local currentTex = GetPedTextureVariation(ped, 11)

    lib.registerContext({
        id = 'tailor_torso',
        title = 'Oberbekleidung anpassen',
        menu = 'tailor_main',
        onExit = function()
            destroyFittingCam()
        end,
        options = {
            {
                title = 'Textur / Naht wechseln',
                description = ('Aktuell: Textur %s'):format(currentTex),
                icon = 'palette',
                onSelect = function()
                    local maxTex = GetNumberOfPedTextureVariations(ped, 11, currentDraw)
                    local nextTex = (currentTex + 1) % maxTex
                    SetPedComponentVariation(ped, 11, currentDraw, nextTex, 0)
                    TriggerServerEvent('zt_tailor:server:saveAdjustment', 11, currentDraw, nextTex)
                    destroyFittingCam()
                end
            },
            {
                title = 'Passform optimieren (Unterbau korrigieren)',
                description = 'Gleicht Arm- und Brustbereich an',
                icon = 'scissors',
                onSelect = function()
                    SetPedComponentVariation(ped, 3, 15, 0, 0)
                    TriggerServerEvent('zt_tailor:server:saveAdjustment', 3, 15, 0)
                    destroyFittingCam()
                end
            }
        }
    })
    lib.showContext('tailor_torso')
end

local function openLegsTuning()
    local ped = PlayerPedId()
    createFittingCam(51826)

    local currentDraw = GetPedDrawableVariation(ped, 4)
    local currentTex = GetPedTextureVariation(ped, 4)

    lib.registerContext({
        id = 'tailor_legs',
        title = 'Beinbekleidung anpassen',
        menu = 'tailor_main',
        onExit = function()
            destroyFittingCam()
        end,
        options = {
            {
                title = 'Hosennaht / Saum wechseln',
                description = ('Aktuell: Textur %s'):format(currentTex),
                icon = 'palette',
                onSelect = function()
                    local maxTex = GetNumberOfPedTextureVariations(ped, 4, currentDraw)
                    local nextTex = (currentTex + 1) % maxTex
                    SetPedComponentVariation(ped, 4, currentDraw, nextTex, 0)
                    TriggerServerEvent('zt_tailor:server:saveAdjustment', 4, currentDraw, nextTex)
                    destroyFittingCam()
                end
            }
        }
    })
    lib.showContext('tailor_legs')
end

local function openFittingMenu()
    lib.registerContext({
        id = 'tailor_main',
        title = 'Massschneiderei - Anpassungstisch',
        options = {
            {
                title = 'Oberkoerper / Jacke',
                description = 'Aermel, Texturen & Passform',
                icon = 'shirt',
                onSelect = openTorsoTuning
            },
            {
                title = 'Beine / Hosen',
                description = 'Beinlaenge, Texturen & Bund',
                icon = 'socks',
                onSelect = openLegsTuning
            }
        }
    })
    lib.showContext('tailor_main')
end

CreateThread(function()
    for _, loc in ipairs(Config.WorkshopLocations) do
        exports.ox_target:addSphereZone({
            coords = loc,
            radius = 1.3,
            options = {
                {
                    name = 'tailor_workbench',
                    label = 'Kleidung anpassen',
                    icon = 'fas fa-scissors',
                    onSelect = function()
                        openFittingMenu()
                    end
                }
            }
        })
    end
end)
