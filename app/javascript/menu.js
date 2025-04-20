import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

document.addEventListener('turbo:load', (event) => {

    var tag = $('.navbar-content').data('filter-tags');
    if (tag != undefined) {
        $('.pc-link').filter('[data-filter-tags="' + tag + '"]').each(function (i, obj) {
            $(obj).closest('.pc-hasmenu').each(function (i, li) {
                $(li).addClass('pc-trigger');
            });
            $(obj).closest('.pc-submenu').each(function (i, ul) {
                $(ul).show();
            });
            $(obj).closest('li').addClass('font-semibold active');
        })
        // $('#js-nav-menu li a').filter('[data-filter-tags="' + tag + '"]').first()
    }
});