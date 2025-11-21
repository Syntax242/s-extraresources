CreateThread(function()
    if not Config.DisableVehicleRadio then return end
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            SetUserRadioControlEnabled(false)
            if GetPlayerRadioStationName() ~= nil then
                SetVehRadioStation(GetVehiclePedIsIn(ped), "OFF")
            end
        end
    end
end)
CreateThread(function()
    if not Config.PunchRequiresFocus then return end
    while true do
        Wait(0)
        DisableControlAction(1, 140, true)
        if not IsPlayerTargettingAnything(PlayerId()) then
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)
CreateThread(function()
    if Config.DisableAmbientSounds then
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        SetAudioFlag("PoliceScannerDisabled", true)
    end
end)
local jumpCount = 0
local lastJumpTime = 0
local isJumping = false
local jumpWindow = 10000 
CreateThread(function()
    if not Config.EnableBunnyhopping then return end
    while true do
        Wait(500)
        local ped = PlayerPedId()
        if IsPedJumping(ped) then
            if not isJumping then
                isJumping = true
                local now = GetGameTimer()
                if (now - lastJumpTime) <= jumpWindow then
                    jumpCount = jumpCount + 1
                else
                    jumpCount = 1
                end
                lastJumpTime = now
                if jumpCount >= Config.RequiredJumps then
                    TriggerEvent("threejump:ragdoll")
                    jumpCount = 0
                end
            end
        else
            isJumping = false
        end
    end
end)
RegisterNetEvent("threejump:ragdoll", function()
    local ped = PlayerPedId()
    SetPedToRagdoll(ped, Config.RagdollTime, Config.RagdollTime, 0, false, false, false)
end)

