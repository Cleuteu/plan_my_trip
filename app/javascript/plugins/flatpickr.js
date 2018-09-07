import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr(".datepicker", {
  enableTime: false,
  minDate: "today",
  altInput: true,
  altFormat: "F j, Y",
})

// flatpickr("#range_start", {
//   mode: "range",
//   minDate: "today",
//   altInput: true,
//   altFormat: "F j, Y",
//   plugins: [new rangePlugin({ input: "#range_end"})]
// })
