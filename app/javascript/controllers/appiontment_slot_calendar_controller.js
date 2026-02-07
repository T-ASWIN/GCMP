import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="appiontment-slot-calendar"
export default class extends Controller {
  static targets = ["picker", "label", "showing"];

  open() {
    if (this.pickerTarget.showPicker) {
      this.pickerTarget.showPicker();
    } else {
      this.pickerTarget.focus();
      this.pickerTarget.click();
    }
  }

  changed() {
    const date = new Date(this.pickerTarget.value);

    const formatted = date.toLocaleDateString("en-GB", {
      day: "numeric",
      month: "short",
    });

    this.labelTarget.textContent = formatted;
    this.showingTarget.textContent = formatted;

    console.log("Load slots for:", this.pickerTarget.value);
  }
}
