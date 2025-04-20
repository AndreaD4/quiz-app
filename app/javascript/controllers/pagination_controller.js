import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reloadTable(event) {
    let url = window.location.href.split('?')[0]
    Turbo.visit(url + '?per_page=' + event.target.value)
  }
}