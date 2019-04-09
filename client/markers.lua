Markers = {}
Markers.showMarkers = false
Markers.markerPositions = {}
Markers.hospitalMarkerPosition = nil

function Markers.StartMarkers(hospitalMarker)
    Markers.showMarkers = true
    Markers.hospitalMarkerPosition = hospitalMarker

    Citizen.CreateThread(function ()
        while Markers.showMarkers do
            Citizen.Wait(10)
    
            for _, markerPosition in pairs(Markers.markerPositions) do
                Markers.DrawMarker(markerPosition, Config.Markers.StartColor)
            end

            Markers.DrawMarker(Markers.hospitalMarkerPosition, Config.Markers.AbortColor)
        end
    end)
end

function Markers.StopMarkers()
    Markers.markerPositions = {}
    Markers.showMarkers = false
end

function Markers.UpdateMarkers(markersTable)
    Markers.markerPositions = markersTable
end

function Markers.DrawMarker(coords)
    local markerSize = Config.Markers.Size
    DrawMarker(22,          -- type, MarkerTypeChevronUpx3
        coords.x,           -- posX
        coords.y,           -- posY
        coords.z + 6.0,     -- posZ
        0,                  -- dirX
        0,                  -- dirY
        0,                  -- dirZ
        0.0,                -- rotX
        180.0,              -- rotY
        0.0,                -- rotZ
        markerSize / 2.0,   -- scaleX
        2.0,                -- scaleY
        10.0,               -- scaleZ
        0,                  -- red
        0,                  -- green
        0,                  -- blue
        100,                -- alpha
        true,               -- bobUpAndDown
        true,               -- faceCamera
        2,                  -- p19 "Typically set to 2. Does not seem to matter directly."
        1,                  -- rotate
        0,                  -- textureDict
        0,                  -- textureName
        0                   -- drawOnEnts
    )
end
