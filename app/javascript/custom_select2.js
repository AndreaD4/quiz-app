import * as Routes from './routes'
import 'select2'
import {add} from "@hotwired/stimulus";
import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

var select2_custom_url = function (element, url) {
    element.select2({
        width: (element.data('width')) ? element.data('width') : '100%',
        placeholder: (element.data('placeholder')) ? element.data('placeholder') : 'Tutti',
        allowClear: (element.data('allow-clear')) ? element.data('allow-clear') : true,
        dataType: 'json',
        language: {
            inputTooShort: function (e) {
                return "Per favore inserisci " + (e.minimum - e.input.length) + " o più caratteri";
            },
            noResults: function () {
                return "Nessun risultato trovato"
            },
            searching: function () {
                return "Sto cercando…"
            },
            loadingMore: function () {
                return "Sto caricando più risultati…"
            }
        },
        ajax: {
            url: url,
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    name: params.term,
                    page: params.page,
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                return {
                    results: data.items,
                    pagination: {
                        more: params.page * 10 < data.total_count
                    }
                };
            },
            cache: true
        },
        escapeMarkup: function (markup) {
            return markup;
        },
        minimumInputLength: 0
    });
};

function initVar(element) {
    let placeholder = ((element.data('placeholder')) ? element.data('placeholder') : 'Tutti');
    let allowClear = ((element.data('allow-clear')) ? element.data('allow-clear') : true);
    let width = ((element.data('width')) ? element.data('width') : '100%');
    let inputTooShort = ((element.data('inputtooshort')) ? element.data('inputtooshort') : 'Digita almeno un carattere...');
    let searching = ((element.data('searching')) ? element.data('searching') : 'Ricerca...');
    let loadingMore = ((element.data('loadingmore')) ? element.data('loadingmore') : 'Caricamento...');
    let noResults = ((element.data('noresults')) ? element.data('noresults') : 'Nessun risultato');
    return {
        placeholder: placeholder,
        allowClear: allowClear,
        width: width,
        inputTooShort: inputTooShort,
        searching: searching,
        loadingMore: loadingMore,
        noResults: noResults
    }
}

function add_class_select2() {
    $('.select2-ajax-custom').each(function () {
        if (!$(this).hasClass('select2-hidden-accessible')) {
            select2_custom_url($(this), $(this).data('url'));
        }
    });

    $('.apply-select2').each(function () {
        if (!$(this).hasClass('select2-hidden-accessible')) {
            values = initVar($(this));
            $(this).select2({
                width: values.width,
                allowClear: values.allowClear,
                placeholder: values.placeholder,
                inputTooShort: function () {
                    return values.inputTooShort;
                },
                'language': {
                    'noResults': function () {
                        let noresults;
                        $('.apply-select2').each(function () {
                            if ($(this).data('select2').isOpen()) {
                                values = initVar($(this));
                                noresults = values.noResults;
                            }
                        })
                        return noresults;
                    }
                }
            });
        }
    });
}

module.exports = add_class_select2;

document.addEventListener('turbo:load', (event) => {

    // Select the node that will be observed for mutations
    var targetNode = document.getElementsByClassName('nested-select2')[0];

    // Options for the observer (which mutations to observe)
    // var config = { attributes: true, childList: true };
    var config = {childList: true, subtree: true};

    // Callback function to execute when mutations are observed
    var callback = function (mutationsList) {
        for (var mutation of mutationsList) {
            if (mutation.type == 'childList') {
                add_class_select2();
            }
        }
    };

    if (targetNode != null) {
        // Create an observer instance linked to the callback function
        var observer = new MutationObserver(callback);

        // Start observing the target node for configured mutations
        observer.observe(targetNode, config);

        // Later, you can stop observing
        // observer.disconnect();
    }
});

$(document).on('select2:open', (e) => {
    document.querySelector('.select2-search__field[aria-controls="select2-' + e.target.id + '-results"]').focus();
});

$(document).on('select2:select select2:clear', '.select2-hidden-accessible', function (e) {
    let event = new Event('change', {bubbles: true}) // fire a native event
    this.dispatchEvent(event);
});