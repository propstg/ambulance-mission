Blips = {}
Blips.patientBlips = {}
Blips.hospitalBlip = nil

function Blips.StartBlips(hospitalLocation)
    Blips.hospitalBlip = Blips.CreateAndInitBlip(hospitalLocation, _('blip_hospital'), false, 61)
end

function Blips.UpdateBlips(coordsList)
    Blips.removeAllPatients()
    Blips.patientBlips = Stream.of(coordsList)
        .map(Blips.CreatePatientBlip)
        .collect()
end

function Blips.CreatePatientBlip(coords)
    return Blips.CreateAndInitBlip(coords, _('blip_patient'), true, 3)
end

function Blips.StopBlips()
    Blips.removeAllPatients()
    RemoveBlip(Blips.hospitalBlip)
end

function Blips.removeAllPatients()
    Stream.of(Blips.patientBlips).forEach(RemoveBlip)
end

function Blips.SetFlashHospital(flashHospital)
    SetBlipFlashes(Blips.hospitalBlip, flashHospital)
end

function Blips.CreateAndInitBlip(coords, blipLabel, isFlashing, sprite)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipAsShortRange(blip, true)
    SetBlipFlashes(blip, isFlashing)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipLabel)
    EndTextCommandSetBlipName(blip)
    return blip
end
