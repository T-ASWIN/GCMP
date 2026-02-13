import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Stimulus connected to:", this.element);
    this.element.innerHTML = "<strong>STIMULUS IS WORKING!</strong>";
    this.element.classList.add("text-green-600", "text-xl");
  }
}
