import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"
import * as Routes from './../routes'

export default class extends Controller {
    connect() {
        document.getElementById('notification-modal').addEventListener('shown.bs.modal', (event) => {
            //Inserire LoadingOverlay
            $.ajax({
                url: Routes.manager_notices_path({
                    format: 'js'
                }),
                cache: false
            });
        });
    }
}