import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  close(event) {
    this.element.remove()
  }
}
