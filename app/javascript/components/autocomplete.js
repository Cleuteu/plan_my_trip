function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var start_location = document.getElementById('start_location');
    var end_location = document.getElementById('end_location');

    if (start_location) {
      var autocomplete = new google.maps.places.Autocomplete(start_location, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(start_location, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }

    if (end_location) {
      var autocomplete = new google.maps.places.Autocomplete(end_location, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(end_location, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    };

  });
}

export { autocomplete };
