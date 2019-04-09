Overlay = {}
Overlay.isVisible = false
Overlay.gameData = {} -- {secondsLeft: xxx, pedsInAmbulance: {}, level: xxx}

function Overlay.Stop()
    Overlay.isVisible = false
end

function Overlay.Start(gameData)
    Overlay.isVisible = true

    Citizen.CreateThread(function()
        while Overlay.isVisible do
            Citizen.Wait(10)
            Overlay.drawTimeLeft()
            Overlay.drawLevel()
            Overlay.drawEmptySeats()
            Overlay.drawPatientsLeft()
        end
    end)
end

function Overlay.drawTimeLeft()
    local minutes = math.floor(gameData.secondsLeft / 60)
    local seconds = math.floor(gameData.secondsLeft - minutes * 60)
    local formattedTime = string.format('%02d:%02d', minutes, seconds)

    drawText(_('overlay_time_left', formattedTime), 0.0, 2.0)
end

function Overlay.drawLevel()
    drawText(_('overlay_level', gameData.level), 10.0, 1.0)
end

function Overlay.drawEmptySeats()
    local emptySeats = Config.MaxPatientsPerTrip - #gameData.pedsInAmbulance
    drawText(_('overlay_empty_seats', emptySeats), 20.0, 1.0)
end

function Overlay.drawPatientsLeft()
    drawText(_('overlay_patients_left', #gameData.peds), 30.0, 1.0)
end

function drawText(text, yOffset, size)
    ESX.Game.Utils.DrawText3D({x = baseCoords.x, y = baseCoords.y + yOffset, z = 0.0}, text, size)
end

function Overlay.Update(gameData)
    Overlay.gameData = gameData
end