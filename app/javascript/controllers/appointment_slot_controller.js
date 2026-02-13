import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { id: Number };

  connect() {
    console.log("Stimulus connected to slot ID:", this.idValue);
  }

  async slot_update() {
    // Changed from toggle()
    const slotId = this.idValue;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    try {
      const response = await fetch(`/appointment_slots/${slotId}/slot_update`, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": csrfToken,
          "Content-Type": "application/json",
        },
      });

      if (response.ok) {
        window.location.reload();
      }
    } catch (error) {
      console.error("Error updating slot:", error);
    }
  }
}
