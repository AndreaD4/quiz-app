import Datepicker from 'vanillajs-datepicker/Datepicker';
import './maskedinput';

document.addEventListener('turbo:load', (event) => {

    Datepicker.locales.it = {
        days: ["Domenica", "Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato"],
        daysShort: ["Dom", "Lun", "Mar", "Mer", "Gio", "Ven", "Sab"],
        daysMin: ["Do", "Lu", "Ma", "Me", "Gi", "Ve", "Sa"],
        months: ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"],
        monthsShort: ["Gen", "Feb", "Mar", "Apr", "Mag", "Giu", "Lug", "Ago", "Set", "Ott", "Nov", "Dic"],
        today: "Oggi",
        monthsTitle: "Mesi",
        clear: "Cancella",
        weekStart: 1,
        format: "dd/mm/yyyy"
    };

    var targetNodes = document.getElementsByClassName('nested-datepicker');

    var config = {childList: true};

    var callback = function (mutationsList) {
        for (var mutation of mutationsList) {
            if (mutation.type == 'childList') {
                applyDatePicker();
            }
        }
    };

    // if (targetNode != null) {
    //     var observer = new MutationObserver(callback);
    //
    //     observer.observe(targetNode, config);
    // }

    Array.prototype.forEach.call(targetNodes, function (targetNode) {
        var observer = new MutationObserver(callback);
        observer.observe(targetNode, config);
    });

    applyDatePicker();
});

document.addEventListener('applydatepicker', (event) => {
    var targetNodes = document.getElementsByClassName('nested-datepicker');

    var config = {childList: true};

    var callback = function (mutationsList) {
        for (var mutation of mutationsList) {
            if (mutation.type == 'childList') {
                applyDatePicker();
            }
        }
    };

    Array.prototype.forEach.call(targetNodes, function (targetNode) {
        var observer = new MutationObserver(callback);
        observer.observe(targetNode, config);
    });
});

function applyDatePicker() {
    Array.from(document.getElementsByClassName('apply-datepicker')).forEach((element, index) => {
        let datepicker = new Datepicker(element, {
            buttonClass: 'btn',
            todayBtn: true,
            clearBtn: true,
            format: "dd/mm/yyyy",
            language: 'it',
            autohide: true
        });

        element.addEventListener('changeDate', (e) => {
            let event = new Event('change', {bubbles: true}) // fire a native event
            element.dispatchEvent(event);
        })
    })

    $('.input-mask-date').mask('99/99/9999');
    $('.input-mask-date-month').mask('99/9999');
    $('.input-mask-date-time').mask('99/99/9999 99:99');
}