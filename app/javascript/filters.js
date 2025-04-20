import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

function get_filters() {
    if (!$('.form-filters').closest('.modal').hasClass('in')) {
        let form_filters = decodeURIComponent($('.form-filters').serialize()).split('&');
        let html = '<span id="span-filters" class="badge border border-primary text-primary ms-6 mb-3"><i class="feather icon-filter me-1"></i>Filtri applicati</span>';
        $('#filters').html(html);
        let filters_count = 0;
        let previous_filter = "";

        // console.log(form_filters);

        form_filters.forEach(function (line) {
            let filter = line.split("=");
            let selector = '.form-filters [name="' + filter[0] + '"]';

            if (filter[1] !== "" && filter[0].indexOf("filters[") !== -1 && !$(selector).is('[disabled=disabled]') && !$(selector).is('[readonly=readonly]') && $(selector).attr('type') !== 'hidden') {
                let label = $('.form-filters label[for="' + filter[0] + '"]').text()
                // console.log(selector, label);
                if (label !== "") {
                    label += ': ';
                }
                if ($(selector).is("input")) {
                    value = $(selector).val();
                } else if ($(selector).data('select2') !== undefined) {
                    var tmp_arr = [];
                    $(selector).select2('data').forEach(function (item) {
                        if (item.text !== "") {
                            tmp_arr.push(item.text);
                        }
                    })
                    value = tmp_arr.join(", ");
                    if (value === undefined || value === "") {
                        $(selector).select2('data').forEach(function (item) {
                            if (item.description !== "") {
                                tmp_arr.push(item.description);
                            }
                        })
                        value = tmp_arr.join(", ");
                        if (value === undefined || value === "") {
                            value = $(selector).data('selected-description');
                            if (value === undefined || value === "") {
                                value = $(selector).data('selectedDescription');
                            }
                        }
                    }
                } else if ($(selector).is("select")) {
                    value = $(selector + ' :selected').text();
                }

                value = value.replaceAll('<br>', ' ');

                var html = '<span class="badge border border-dark text-dark ms-2 remove-badge-filter" data-element-id="' + $(selector).attr('id') + '"><i class="feather icon-x me-1"></i>' + label + '<b>' + value + '</b> </span>';

                if (filter[0] !== previous_filter) {
                    $('#filters').append(html);
                }

                previous_filter = filter[0];
                filters_count += 1;
            }
        });

        if (filters_count === 0) {
            $('#filters').html("");
        } else {
            $('#filters').append("<div class='space-2'></div>");
        }
    }

    // $('[data-rel=tooltip]').tooltip();
}

// function get_report_filters(form) {
//     var form_filters = decodeURIComponent(form.serialize()).split('&');
//     var form_id = form.attr('id')
//     var previous_filter = "";
//     var element = {}
//
//     form_filters.forEach(function (line) {
//         var filter = line.split("=");
//         var selector = '#' + form_id + ' [name="' + filter[0] + '"]';
//         var field_name = filter[0].replace('report[', '').replace(']', '').replace('[]','')
//         var field_value = filter[1]
//
//         if (field_value !== "" && filter[0].indexOf("report[") !== -1 && !$(selector).is('[disabled=disabled]') && !$(selector).is('[readonly=readonly]') && $(selector).attr('type') !== 'hidden') {
//             label = $('#' + form_id + ' label[for="' + filter[0] + '"]').text()
//             if (label === "") {
//                 return;
//             }
//             if ($(selector).is("input")) {
//                 value = $(selector).val();
//             } else if ($(selector).data('select2') !== undefined) {
//                 var tmp_arr = [];
//                 $(selector).select2('data').forEach(function (item) {
//                     if (item.text !== "") {
//                         tmp_arr.push(item.text);
//                     }
//                 })
//                 value = tmp_arr.join(", ");
//                 if (value === undefined || value === "") {
//                     $(selector).select2('data').forEach(function (item) {
//                         if (item.description !== "") {
//                             tmp_arr.push(item.description);
//                         }
//                     })
//                     value = tmp_arr.join(", ");
//                     if (value === undefined || value === "") {
//                         value = $(selector).data('selected-description');
//                         if (value === undefined || value === "") {
//                             value = $(selector).data('selectedDescription');
//                         }
//                     }
//                 }
//             } else if ($(selector).is("select")) {
//                 value = $(selector + ' :selected').text();
//             }
//
//             label = label.replace('*', '').trim()
//
//             element[field_name] = label + '|' + value
//
//             previous_filter = field_name;
//         }
//     });
//
//     $('[data-rel=tooltip]').tooltip();
//     return element
// }

$(document).on('click', '.remove-badge-filter', function (e) {
    // $(this).closest('.page-content').find('table').LoadingOverlay('show')
    let element_id = $(this).data('element-id');
    $(this).remove();
    $('#' + element_id).val('').trigger('change');
    $('#' + element_id).closest('form').submit();
});

module.exports = get_filters;