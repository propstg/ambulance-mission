Log = {}

function Log.debug(message)
    if Config.DebugLog then
        Wrapper.print(message)
    end
end