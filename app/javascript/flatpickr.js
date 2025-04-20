import { Italian } from "flatpickr/dist/l10n/it.js"
document.addEventListener('turbo:load', (event) => {

    var targetNode = document.getElementsByClassName('nested-flatpicker')[0];

    var config = {childList: true};

    var callback = function (mutationsList) {
        for (var mutation of mutationsList) {
            if (mutation.type == 'childList') {
                applyFlatPicker();
            }
        }
    };

    if (targetNode != null) {
        var observer = new MutationObserver(callback);

        observer.observe(targetNode, config);
    }

    applyFlatPicker();
});


function applyFlatPicker() {
    Array.from(document.getElementsByClassName('apply-flatpicker')).forEach((element, index) => {
        element.flatpickr({
            locale: Italian,
            dateFormat: "d/m/Y",
            mode: "range"
        });
    })

    Array.from(document.getElementsByClassName('apply-flatpicker-time')).forEach((element, index) => {
        element.flatpickr({
            locale: Italian,
            // mode: "multiple",
            enableTime: true,
            dateFormat: "d/m/Y H:i"
            // minTime: "00:00",
            // maxTime: "24:00"
        });
    })
}