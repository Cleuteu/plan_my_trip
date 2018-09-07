import GMaps from 'gmaps/gmaps.js';

const mapElement = document.getElementById('map');

if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = new GMaps({ el: '#map', lat: 0, lng: 0, zoomControl: false, mapTypeControl: false, streetViewControl: false, fullscreenControl: false });
  const markers = JSON.parse(mapElement.dataset.markers);

  // // Here we store map markers in an array BEFORE adding them to the map
  // const mapMarkers = [];
  //   markers.forEach((marker) => {
  //     const mapMarker = map.createMarker(marker);
  //     mapMarkers.push(mapMarker);
  //     map.addMarker(mapMarker);
  //   });

  // map.addMarkers(markers);
  // if (markers.length === 0) {
  //   map.setZoom(2);
  // } else if (markers.length === 1) {
  //   map.setCenter(markers[0].lat, markers[0].lng);
  //   map.setZoom(14);
  // } else {
  //   map.fitLatLngBounds(markers);
  // }

  // // Map marker animation
  // // Select all events
  // const events = document.querySelectorAll('.event');
  // events.forEach((event, index) => {
  //   // Put a microphone on each event listenning for a hover event
  //   event.addEventListener('mouseenter', () => {
  //     // Here we trigger the display of the corresponding marker infoWindow as it is the default behavior of a click on a  marker
  //     google.maps.event.trigger(mapMarkers[index], 'click');
  //   });
  // });

  // const styles = [ {
  //       "featureType": "all",
  //       "elementType": "all",
  //       "stylers": [
  //           {
  //               "hue": "#008eff"
  //           }
  //       ]
  //   },
  //   {
  //       "featureType": "poi",
  //       "elementType": "all",
  //       "stylers": [
  //           {
  //               "visibility": "off"
  //           }
  //       ]
  //   },
  //   {
  //       "featureType": "road",
  //       "elementType": "all",
  //       "stylers": [
  //           {
  //               "saturation": "0"
  //           },
  //           {
  //               "lightness": "0"
  //           }
  //       ]
  //   },
  //   {
  //       "featureType": "transit",
  //       "elementType": "all",
  //       "stylers": [
  //           {
  //               "visibility": "off"
  //           }
  //       ]
  //   },
  //   {
  //       "featureType": "water",
  //       "elementType": "all",
  //       "stylers": [
  //           {
  //               "visibility": "simplified"
  //           },
  //           {
  //               "saturation": "-60"
  //           },
  //           {
  //               "lightness": "-20"
  //           }
  //       ]
  //   } ];

  // map.addStyle({
  //   styles: styles,
  //   mapTypeId: 'map_style'
  // });
  // map.setStyle('map_style');
}

import { autocomplete } from '../components/autocomplete';



// Get directions et draw map

function calculateRoute(from, to, array) {
    // Center initialized to Naples, Italy

    var myOptions = {
      zoom: 10,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: [ {
        "featureType": "all",
        "elementType": "all",
        "stylers": [
            {
                "hue": "#008eff"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "saturation": "0"
            },
            {
                "lightness": "0"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "saturation": "-60"
            },
            {
                "lightness": "-20"
            }
        ]
    } ]

    };
    // Draw the map
    var mapObject = new google.maps.Map(document.getElementById("map"), myOptions);

    var directionsService = new google.maps.DirectionsService();
    var directionsRequest = {
      origin: from,
      destination: to,
      waypoints: array,
      travelMode: google.maps.DirectionsTravelMode.DRIVING,
      unitSystem: google.maps.UnitSystem.METRIC
    };
    directionsService.route(
      directionsRequest,
      function(response, status)
      {
        if (status == google.maps.DirectionsStatus.OK)
        {
          new google.maps.DirectionsRenderer({
            map: mapObject,
            directions: response
          });
        }
        else
          $("#error").append("Unable to retrieve your route<br />");
      }
    );
  //   // Map marker animation
  // // Select all events
  // const events = document.querySelectorAll('.event');
  // events.forEach((event, index) => {
  //   // Put a microphone on each event listenning for a hover event
  //   event.addEventListener('mouseenter', () => {
  //     // Here we trigger the display of the corresponding marker infoWindow as it is the default behavior of a click on a  marker
  //     google.maps.event.trigger(mapMarkers[index], 'click');
  //   });
  // });
  // const mapElement = document.getElementById('map');

  // const markers = JSON.parse(mapElement.dataset.markers);

  // // Here we store map markers in an array BEFORE adding them to the map
  // const mapMarkers = [];
  //   markers.forEach((marker) => {
  //     const mapMarker = map.createMarker(marker);
  //     mapMarkers.push(mapMarker);
  //     map.addMarker(mapMarker);
  //   });
  }


  $(document).ready(function() {
    // If the browser supports the Geolocation API
    if (typeof navigator.geolocation == "undefined") {
      $("#error").text("Your browser doesn't support the Geolocation API");
      return;
    }

    $("#from-link, #to-link").click(function(event) {
      event.preventDefault();
      var addressId = this.id.substring(0, this.id.indexOf("-"));

      navigator.geolocation.getCurrentPosition(function(position) {
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({
          "location": new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
        },
        function(results, status) {
          if (status == google.maps.GeocoderStatus.OK)
            $("#" + addressId).val(results[0].formatted_address);
          else
            $("#error").append("Unable to retrieve your address<br />");
        });
      },
      function(positionError){
        $("#error").append("Error: " + positionError.message + "<br />");
      },
      {
        enableHighAccuracy: true,
        timeout: 10 * 1000 // 10 seconds
      });
    });

    var steps = [];
    const locationsArray = JSON.parse(mapElement.dataset.markers).map( x => `${x.location}`)

   locationsArray.forEach((location) => {
     steps.push(

    {
      location: location,
      stopover: true
      })
    });

   // console.log(steps)
      calculateRoute('Montreal', 'Montreal', steps);
    });





autocomplete();
