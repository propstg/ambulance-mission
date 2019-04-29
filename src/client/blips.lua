Blips = {}
Blips.patientBlips = {}
Blips.hospitalBlip = nil

function Blips.StartBlips(hospitalLocation)
    Blips.hospitalBlip = Blips.createAndInitBlip(hospitalLocation, Wrapper._('blip_hospital'), false, 61)
end

function Blips.UpdateBlips(coordsList)
    Blips.removeAllPatients()
    Blips.patientBlips = Stream.of(coordsList)
        .map(Blips.createPatientBlip)
        .collect()
end

function Blips.StopBlips()
    Blips.removeAllPatients()
    Wrapper.RemoveBlip(Blips.hospitalBlip)
end

function Blips.SetFlashHospital(flashHospital)
    Wrapper.SetBlipFlashes(Blips.hospitalBlip, flashHospital)
end

function Blips.removeAllPatients()
    Stream.of(Blips.patientBlips).forEach(Wrapper.RemoveBlip)
end

function Blips.createPatientBlip(coords)
    return Blips.createAndInitBlip(coords, Wrapper._('blip_patient'), true, 3)
end

function Blips.createAndInitBlip(coords, blipLabel, isFlashing, sprite)
    local blip = Wrapper.AddBlipForCoord(coords.x, coords.y, coords.z)
    Wrapper.SetBlipSprite(blip, sprite)
    Wrapper.SetBlipAsShortRange(blip, true)
    Wrapper.SetBlipFlashes(blip, isFlashing)
    Wrapper.BeginTextCommandSetBlipName('STRING')
    Wrapper.AddTextComponentString(blipLabel)
    Wrapper.EndTextCommandSetBlipName(blip)
    return blip
end