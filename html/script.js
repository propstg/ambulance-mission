class Hud {

    constructor() {
        window.addEventListener('message', event => {
            switch (event.data.type) {
                case 'init':                return this.initLanguageFields(event.data.translatedLabels);
                case 'changeVisibility':    return this.changeVisibility(event.data.visible);
                case 'tick':                return this.handleTick(event.data);
            }
        });

        this.level = $('#level');
        this.timeLeft = $('#time-left');
        this.emptySeats = $('#empty-seats');
        this.patientsLeft = $('#patients-left');
    }

    initLanguageFields = translatedLabels => Object.entries(translatedLabels)
        .forEach(entry => $(`#${entry[0]}`).html(entry[1]));

    changeVisibility = isVisible => document.body.style.display = isVisible ? 'block' : 'none';

    handleTick = data => {
        this.level.text(data.level);
        this.timeLeft.text(data.timeLeft);
        this.emptySeats.text(data.emptySeats);
        this.patientsLeft.text(data.patientsLeft);
    };
}

$(() => new Hud());
