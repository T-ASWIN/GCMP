import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

// This tells Stimulus to look at your importmap pins
eagerLoadControllersFrom("controllers", application);
