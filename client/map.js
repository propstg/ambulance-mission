const Map = {
    filter: (array, func) => array.filter(func),
    map: (array, func) => array.map(func),
    forEach: (array, func) => array.forEach(func),
    shuffle: (array) => array.map(a => [Math.random(), a]).sort((a, b) => a[0] - b[0]).map(a => a[1])
}