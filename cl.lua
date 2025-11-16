CreateThread(function()
    while true do
        Wait(1000)

        if Config.DisableVehicleRadio then
            local ped = PlayerPedId()

            if IsPedInAnyVehicle(ped, false) then
                SetUserRadioControlEnabled(false)
                if GetPlayerRadioStationName() ~= nil then
                    SetVehRadioStation(GetVehiclePedIsIn(ped), "OFF")
                end
            end
        else
            SetUserRadioControlEnabled(true)
        end
    end
end)
CreateThread(function()
    while true do
        Wait(0)

        if Config.PunchRequiresFocus then
            DisableControlAction(1, 140, true)

            if not IsPlayerTargettingAnything(PlayerId()) then
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            end
        end
    end
end)
CreateThread(function()
    if Config.DisableAmbientSounds then
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        SetAudioFlag("PoliceScannerDisabled", true)
    end
end)
