class Map {

    static test(array) {
        console.log(array);
    }

    static filter(array, func) {
        return array.filter(func);
    }

    static map(array, func) {
        return array.map(func);
    }

    static forEach(array, func) {
        return array.forEach(func);
    }

    static shuffle(array) {
        return array.map(a => [Math.random(), a]).sort((a, b) => a[0] - b[0]).map(a => a[1]);
    }
}

/*
Map.test = (array) => console.log(array);

Map.filter = (array, func) => array.filter(func);

Map.map = (array, func) => array.map(func);

Map.forEach = (array, func) => array.forEach(func);



Map.shuffle = (array) => array.map(a => [Math.random(), a]).sort((a, b) => a[0] - b[0]).map(a => a[1]);
*/
