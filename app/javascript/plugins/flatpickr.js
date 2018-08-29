import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"


flatpickr(".datepicker", {
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  mode: "range",
  minDate: "today",
})


flatpickr("#range_start", {
  mode: "range",
  inline: true,
  dateFormat: "Y-m-d",
  plugins: [new rangePlugin({ input: "#range_end"})]
})
