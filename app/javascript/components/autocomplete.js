function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    const start_location = document.getElementById('start_location');
    const end_location = document.getElementById('end_location');
    const locations = document.querySelectorAll('input.event_location');

    if (start_location) {
      const autocomplete = new google.maps.places.Autocomplete(start_location, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(start_location, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }

    if (end_location) {
      const autocomplete = new google.maps.places.Autocomplete(end_location, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(end_location, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    };

    if (locations) {
      locations.forEach((location) => {
        const autocomplete = new google.maps.places.Autocomplete(location, { types: [ 'geocode' ] });
        google.maps.event.addDomListener(location, 'keydown', function(e) {
          if (e.key === "Enter") {
            e.preventDefault(); // Do not submit the form on Enter.
          }
        });
      });
    };

  });
}

export { autocomplete };
