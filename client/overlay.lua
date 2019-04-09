Overlay = {}
Overlay.ESX = nil
Overlay.isVisible = false
Overlay.gameData = {} -- {secondsLeft: xxx, pedsInAmbulance: {}, level: xxx}

function Overlay.Stop()
    Overlay.isVisible = false
end

function Overlay.Start(ESX, gameData)
    Overlay.ESX = ESX
    Overlay.isVisible = true
    Overlay.gameData = gameData

    Citizen.CreateThread(function()
        while Overlay.isVisible do
            Citizen.Wait(5)
            Overlay.drawTimeLeft()
            Overlay.drawLevel()
            Overlay.drawEmptySeats()
            Overlay.drawPatientsLeft()
        end
    end)
end

function Overlay.drawTimeLeft()
    local minutes = math.floor(Overlay.gameData.secondsLeft / 60)
    local seconds = math.floor(Overlay.gameData.secondsLeft - minutes * 60)
    local formattedTime = string.format('%02d:%02d', minutes, seconds)

    drawTxt(1.35, 0.80, 1.0, 1.0, 0.5, _('overlay_time_left', formattedTime), 255, 255, 255, 255)
end

function Overlay.drawLevel()
    drawTxt(1.35, 0.84, 1.0, 1.0, 0.4, _('overlay_level', Overlay.gameData.level), 255, 255, 255, 255)
end

function Overlay.drawEmptySeats()
    local emptySeats = Config.MaxPatientsPerTrip - #Overlay.gameData.pedsInAmbulance
    drawTxt(1.35, 0.87, 1.0, 1.0, 0.4, _('overlay_empty_seats', emptySeats), 255, 255, 255, 255)
end

function Overlay.drawPatientsLeft()
    drawTxt(1.35, 0.90, 1.0, 1.0, 0.4, _('overlay_patients_left', #Overlay.gameData.peds), 255, 255, 255, 255)
end

function drawText(text, yOffset, size)
    local baseCoords = Config.OverlayBaseCoords

end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function Overlay.Update(gameData)
    Overlay.gameData = gameData
end
