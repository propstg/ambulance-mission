Markers = {}
Markers.showMarkers = false
Markers.showHospital = false
Markers.markerPositions = {}
Markers.hospitalMarkerPosition = nil
Markers.markerSize = Config.Markers.Size / 2.0

function Markers.StartMarkers(hospitalMarker)
    Markers.showMarkers = true
    Markers.hospitalMarkerPosition = hospitalMarker

    Citizen.CreateThread(function()
        while Markers.showMarkers do
            Citizen.Wait(10)

            Stream.of(Markers.markerPositions).forEach(Markers.drawPedMarker)

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
        2.0,
        10.0,
        true
    )
end

function Markers.drawHospitalMarker(coords)
    Markers.drawMarker(coords,
        1, -- MarkerTypeVerticalCylinder
        0.0,
        Markers.markerSize,
        -1.0,
        false
    )
end

function Markers.drawMarker(coords, type, yRot, scaleY, zOffset, bobUpAndDown)
    Wrapper.DrawMarker(type,-- type
        coords.x,           -- posX
        coords.y,           -- posY
        coords.z + zOffset, -- posZ
        0,                  -- dirX
        0,                  -- dirY
        0,                  -- dirZ
        0.0,                -- rotX
        yRot,               -- rotY
        0.0,                -- rotZ
        Markers.markerSize, -- scaleX
        scaleY,             -- scaleY
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
