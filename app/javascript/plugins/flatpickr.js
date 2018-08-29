import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr("#range_start", {
  mode: "range",
  minDate: "today",
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  plugins: [new rangePlugin({ input: "#range_end"})]
})
