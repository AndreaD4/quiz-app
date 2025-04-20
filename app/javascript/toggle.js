import * as feather from "feather-icons/dist/feather.min"
import * as bootstrap from "bootstrap";

document.addEventListener('turbo:load', (event) => {

    var targetNode = document.getElementsByClassName('replace-bs-toggle')[0];

    var config = {childList: true};

    var callback = function (mutationsList) {
        for (var mutation of mutationsList) {
            if (mutation.type == 'childList') {
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
            }
        }
    };

    if (targetNode != null) {
        var observer = new MutationObserver(callback);

        observer.observe(targetNode, config);
    }
});