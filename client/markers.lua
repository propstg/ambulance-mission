Markers = {}
Markers.showMarkers = false
Markers.showHospital = false
Markers.markerPositions = {}
Markers.hospitalMarkerPosition = nil

function Markers.StartMarkers(hospitalMarker)
    Markers.showMarkers = true
    Markers.hospitalMarkerPosition = hospitalMarker

    Citizen.CreateThread(function ()
        while Markers.showMarkers do
            Citizen.Wait(10)
    
            for _, markerPosition in pairs(Markers.markerPositions) do
                Markers.drawPedMarker(markerPosition)
            end

            if Markers.showHospital then
                Markers.drawHospitalMarker(Markers.hospitalMarkerPosition)
            end
        end
    end)
end

function Markers.StopMarkers()
    Markers.markerPositions = {}
    Markers.showMarkers = false
    Markers.showHospital = false
end

function Markers.UpdateMarkers(markersTable)
    Markers.markerPositions = markersTable
end

function Markers.SetShowHospital(showHospital)
    Markers.showHospital = showHospital
end

function Markers.drawPedMarker(coords)
    Markers.drawMarker(coords,
        22, -- MarkerTypeChevronUpx3
        180.0,
        10.0,
        true
    )
end

function Markers.drawHospitalMarker(coords)
    Markers.drawMarker(coords,
        1, -- MarkerTypeVerticalCylinder
        0.0,
        0.0,
        false
    )
end

function Markers.drawMarker(coords, type, yRot, zOffset, bobUpAndDown)
    local markerSize = Config.Markers.Size / 2.0

    DrawMarker(type,        -- type
        coords.x,           -- posX
        coords.y,           -- posY
        coords.z zOffset,   -- posZ
        0,                  -- dirX
        0,                  -- dirY
        0,                  -- dirZ
        0.0,                -- rotX
        yRot,               -- rotY
        0.0,                -- rotZ
        markerSize,         -- scaleX
        2.0,                -- scaleY
        10.0,               -- scaleZ
        0,                  -- red
        0,                  -- green
        150,                -- blue
        100,                -- alpha
        bobUpAndDown,       -- bobUpAndDown
        true,               -- faceCamera
        2,                  -- p19 "Typically set to 2. Does not seem to matter directly."
        1,                  -- rotate
        0,                  -- textureDict
        0,                  -- textureName
        0                   -- drawOnEnts
    )
end
