import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["template", "target"];

  initialize() {
    this.templateHTML = this.templateTarget.innerHTML;
  }

  add() {
    const newField = this.templateHTML.replace(
      /RECORD_INDEX/g,
      new Date().getTime().toString()
    );

    // Insert template content before the target div.
    this.targetTarget.insertAdjacentHTML("beforebegin", newField);
  }
}
