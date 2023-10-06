import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["total"]

  connect() {
  }

  update(event) {
    let seatElement = event.currentTarget;
    let seatState = seatElement.dataset.seatState;
    let seatCost = parseFloat(seatElement.dataset.seatCost);
    let currentTotal = parseFloat(this.totalTarget.innerText);

    if (seatState == "free") {
      currentTotal += seatCost;
    } else {
      currentTotal -= seatCost;
    }

    this.totalTarget.innerText = currentTotal.toFixed(2);
  }
}
