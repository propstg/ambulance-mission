Blips = {}
Blips.patientBlips = {}
Blips.hospitalBlip = nil

function Blips.StartBlips(hospitalLocation)
    Blips.hospitalBlip = Blips.CreateAndInitBlip(hospitalLocation, _('blip_hospital'))
end

function Blips.UpdateBlips(coordsList)
    Blips.removeAllPatients()
    Blips.patientBlips = Map.map(coordsList, function(coords)
        return Blips.CreateAndInitBlip(coords, _('blip_patient'))
    end)
end

function Blips.StopBlips()
    Blips.removeAllPatients()
    RemoveBlip(Blips.hospitalBlip)
end

function Blips.removeAllPatients()
    Map.forEach(Blips.patientBlips, function(blip)
        RemoveBlip(blip)
    end)
end

function Blips.CreateAndInitBlip(coords, blipLabel)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 513)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipLabel)
    EndTextCommandSetBlipName(blip)
    return blip
end