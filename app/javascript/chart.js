import ApexCharts from "apexcharts/dist/apexcharts.min.js"
import Datepicker from "vanillajs-datepicker/Datepicker";

var charts = [];

document.addEventListener("DOMContentLoaded", function () {
    var machines = document.getElementsByClassName("machine-chart");
    Array.prototype.filter.call(machines, function (machine) {
        var options = {
            yaxis: {title: {text: 'Gradi'}},
            title: {text: machine.dataset.title},
            chart: {
                toolbar: {show: false},
                height: 350,
                type: 'area',
            },
            dataLabels: {
                enabled: false
            },
            stroke: {
                curve: 'smooth'
            },
            colors: ["#ffa21d"],
            series: [{
                name: 'Temperatura',
                data: JSON.parse(machine.dataset.values)
            }],
            xaxis: {
                type: 'datetime',
                categories: JSON.parse(machine.dataset.categories),
            },
            tooltip: {
                x: {
                    format: 'dd/MM/yy HH:mm'
                },
            }
        }

        var chart = new ApexCharts(
            machine,
            options
        );

        chart.render();

        charts.push({id: machine.id, object: chart})
    });

});

document.addEventListener('turbo:load', (event) => {

    var targetNode = document.getElementById('chart-data');

    var config = {childList: true, attributes: true, subtree: true};

    var callback = function (mutationsList) {
        for (var mutation of mutationsList) {
            if (mutation.type == 'childList') {
                Array.prototype.filter.call(charts, function (chart) {
                    chart['object'].updateOptions({
                        xaxis: {
                            type: 'datetime',
                            categories: JSON.parse(document.querySelector('[data-chart-id="' + chart['id'] + '"]').dataset.categories),
                        },
                        series: [{
                            name: 'Temperatura',
                            data: JSON.parse(document.querySelector('[data-chart-id="' + chart['id'] + '"]').dataset.values),
                        }],
                    });
                })
            }
        }
    };

    if (targetNode != null) {
        var observer = new MutationObserver(callback);

        observer.observe(targetNode, config);
    }
});