Stream = {}

function Stream.of(array)

    local function __filter(func)
        local returnTable = {}

        for index, v in pairs(array) do
            if func(v, index) then
                table.insert(returnTable, v)
            end
        end

        return Stream.of(returnTable)
    end

    local function __map(func)
        local returnTable = {}

        for index, v in pairs(array) do
            table.insert(returnTable, func(v, index))
        end

        return Stream.of(returnTable)
    end

    local function __shuffle()
        for i = #array, 2, -1 do
            local j = math.random(i)
            array[i], array[j] = array[j], array[i]
        end

        return Stream.of(array)
    end

    -- terminators:

    local function __forEach(func)
        for index, value in pairs(array) do
            func(value, index)
        end
    end

    local function __collect()
        return array
    end

    local function __anyMatch(func)
        for index, value in pairs(array) do
            if func(value, index) then
                return true
            end
        end

        return false
    end

    return {
        filter = __filter,
        map = __map,
        shuffle = __shuffle,

        forEach = __forEach,
        collect = __collect,
        anyMatch = __anyMatch
    }
end
