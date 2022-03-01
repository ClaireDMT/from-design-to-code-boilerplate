import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "input", "list"]

  // connect() {
  //   console.log(this.formTarget)
  //   console.log(this.inputTarget)
  //   console.log(this.listTarget)
  // }

  update() {
    const query = this.inputTarget.value
    const url = `${this.formTarget.action}?query=${query}`

  fetch(url, { headers: { "Accept": "text/plain" } })
    .then(response => response.text()) // response object (with headers and info on your request) => keep just the text (our partial)
    .then((data) => {
      this.listTarget.outerHTML = data // replace the old list wih the filtered movies
    })  }
}
