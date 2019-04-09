Map = {}

function Map.filter(array, func)
    local returnTable = {};

    for index, v in pairs(array) do
        if func(v, index) then
            table.insert(returnTable, v)
        end
    end

    return returnTable
end

function Map.map(array, func)
    local returnTable = {};

    for _, v in pairs(array) do
        table.insert(returnTable, func(v))
    end
    
    return returnTable
end

function Map.forEach(array, func)
    for index, value in pairs(array) do
        func(value, index)
    end
end

function Map.shuffle(array)
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
    end

    return array
end