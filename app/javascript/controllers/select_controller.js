import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  params = new URLSearchParams(window.location.search)

  connect() {
    this.element.value = this.params.get('sort')
  }

  filter() {
    const query = this.element.value
    this.params.set('sort', query)
    window.location.search = this.params.toString()
  }
}
