import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"
import get_filters from "../filters"

export default class extends Controller {
  hideModalFilters() {
    let modal_element = document.getElementsByClassName('modal-filters')[0];
    let modal = bootstrap.Modal.getInstance(modal_element);
    modal.hide();
  }

  resetFilters(){
    let form = document.getElementsByClassName('form-filters')[0];
    let selects = form.getElementsByTagName("select");
    let inputs = form.getElementsByTagName("input");

    Array.prototype.forEach.call(selects, function (element, index){
      element.value = '';
    });
    Array.prototype.forEach.call(inputs, function (element, index){
      if (element.type === 'text')
        element.value = '';
    });

    document.getElementById('btn-apply-filters').click();
  }

  replaceFiltersData(){
    setTimeout((function () {
      let filter_data = document.getElementById('filters_data');
      let filters_count = filter_data.getAttribute('data-filters-count');
      let records_count = filter_data.getAttribute('data-records-count');
      document.getElementById('filters_count').innerHTML = filters_count;
      document.getElementById('records_count').innerHTML = records_count + ' record';
      get_filters();
    }), 100);
  }
}
