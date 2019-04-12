class Hud {

    constructor() {
        console.log('constructor called');
        window.addEventListener('message', event => {
            console.log("event receieved");
            switch (event.data.type) {
                case 'init': return this.initLanguageFields(event.data.translatedLabels);
                case 'changeVisibility': return this.changeVisibility(event.data.visible);
                case 'tick': return this.handleTick(event.data);
            }
        });

        this.level = $('#level');
        this.timeLeft = $('#time-left');
        this.emptySeats = $('#empty-seats');
        this.patientsLeft = $('#patients-left');
    }

    initLanguageFields = translatedLabels => {
        console.log('init event');
        console.log(translatedLabels);

        Object.entries(translatedLabels).forEach(entry => {
            $(`#${entry[0]}`).html(entry[1]);
        });
    };

    changeVisibility = isVisible => {
        if (isVisible) {
            document.body.style.display = 'block';
        } else {
            document.body.style.display = 'none';
        }
    };

    handleTick = data => {
        console.log('tick');
        console.log(data);

        this.level.text(data.level);
        this.timeLeft.text(data.timeLeft);
        this.emptySeats.text(data.emptySeats);
        this.patientsLeft.text(data.patientsLeft);
    };
}

$(() => new Hud());
