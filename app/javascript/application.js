import "@hotwired/turbo-rails"
import "./controllers"

import "perfect-scrollbar/dist/perfect-scrollbar.min"
import * as feather from "feather-icons/dist/feather.min"
import * as bootstrap from "bootstrap";
import "bootstrap/dist/js/*.js"

import 'flatpickr'
import 'vanillajs-datepicker'

import 'cocoon-js'
import "./letterAvatar"
import "./pcoded"

// import "./pages/dashboard-sale"
// import "./footer-bottom"

import get_filters from "./filters"

import("select2").then(m => m.default());

import add_class_select2 from "./custom_select2"

import "./menu"
import "./feather"
import "./toggle"
import "./datepicker"
import "./flatpickr"

document.addEventListener('turbo:load', (event) => {
    window.Turbo.setProgressBarDelay(1);

    window.history.pushState(null, "", window.location.href);
    window.onpopstate = function () {
        window.history.pushState(null, "", window.location.href);
    };

    feather.replace();

    var forms = document.getElementsByClassName('needs-validation');

    Array.prototype.filter.call(forms, function (form) {
        form.addEventListener('submit', function (event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            for (i = 0; i < form.elements.length; ++i) {
                if (form.elements[i].classList.toString().indexOf('select2-hidden-accessible') != -1) {
                    if (form.elements[i].validity.valid) {
                        let selection_single = form.elements[i].closest(form.elements[i].dataset.closest).getElementsByClassName("select2-selection--single")[0]
                        let selection_multiple = form.elements[i].closest(form.elements[i].dataset.closest).getElementsByClassName("select2-selection--multiple")[0]
                        if (selection_single) {
                            selection_single.classList.remove('red-border');
                            selection_single.classList.add('green-border');
                        } else if (selection_multiple) {
                            selection_multiple.classList.remove('red-border');
                            selection_multiple.classList.add('green-border');
                        }
                    } else {
                        let selection_single = form.elements[i].closest(form.elements[i].dataset.closest).getElementsByClassName("select2-selection--single")[0]
                        let selection_multiple = form.elements[i].closest(form.elements[i].dataset.closest).getElementsByClassName("select2-selection--multiple")[0]
                        if (selection_single) {
                            selection_single.classList.add('red-border');
                            selection_single.classList.remove('green-border');
                        } else if (selection_multiple) {
                            selection_multiple.classList.add('red-border');
                            selection_multiple.classList.remove('green-border');
                        }
                    }
                }
            }
            form.classList.add('was-validated');
            if ($('.invalid-feedback:first:visible').length > 0) {
                $('html, body').animate({
                    scrollTop: $('.invalid-feedback:first:visible').offset().top - 200
                }, 100);
            }
        }, false);
    });

    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })

    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    });

    var toastElList = [].slice.call(document.querySelectorAll('.toast'))
    toastElList.map(function (toastEl) {
        return new bootstrap.Toast(toastEl)
    })

    add_class_select2();
    get_filters();

    setTimeout((function () {
        if ($('.need-back-validation').length > 0) {
            $('.need-back-validation').data('form-serialize', $('.need-back-validation *[name!=authenticity_token]').serialize())
        }
    }), 1000);
});

$(document).on('click', '.btn-delete-attachment', function (e) {
    e.preventDefault();

    var link = $(this).data('link');
    var attachment = $(this);

    if (window.confirm("Sei sicuro di voler cancellare l\'allegato?\nQuesta operazione non può essere annullata.")) {
        $.ajax({
            url: link,
            method: 'delete',
            dataType: 'json',
            contentType: "application/json",
            cache: false,
            success: function (data) {
                attachment.closest('tr').remove();
            },
            error: function () {
                return alert('Si è verificato un errore. Riprovare più tardi.');
            }
        });
    }
});


$(document).on('click', '.check-changes-form', function (e) {
    let element = $(this)
    if ($('.need-back-validation').length > 0) {
        if ($('.need-back-validation').data('form-serialize') != $('.need-back-validation *[name!=authenticity_token]').serialize()) {
            e.preventDefault();
            let result = confirm('Proseguendo perderai le modifiche non salvate, sei sicuro?')
            if (result) {
                if (element.attr('href')) {
                    Turbo.visit(element.attr('href'))
                } else if (element.data('target')) {
                    $(element.data('target')).modal('show')
                }
            }
        } else if (element.data('target')) {
            $(element.data('target')).modal('show')
        }
    }
});