import * as feather from "feather-icons/dist/feather.min"

document.addEventListener('turbo:load', (event) => {

    var targetNode = document.getElementsByClassName('replace-feather-icon')[0];

    var config = {childList: true};

    var callback = function (mutationsList) {
        for (var mutation of mutationsList) {
            if (mutation.type == 'childList') {
                feather.replace();
            }
        }
    };

    if (targetNode != null) {
        var observer = new MutationObserver(callback);

        observer.observe(targetNode, config);
    }
});