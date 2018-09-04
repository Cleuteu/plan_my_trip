import GMaps from 'gmaps/gmaps.js';

const mapElement = document.getElementById('map');

if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = new GMaps({ el: '#map', lat: 0, lng: 0, zoomControl: false, mapTypeControl: false, streetViewControl: false, fullscreenControl: false });
  const markers = JSON.parse(mapElement.dataset.markers);

  // Here we store map markers in an array BEFORE adding them to the map
  const mapMarkers = [];
    markers.forEach((marker) => {
      const mapMarker = map.createMarker(marker);
      mapMarkers.push(mapMarker);
      map.addMarker(mapMarker);
    });

  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markers);
  }

  // Map marker animation
  // Select all events
  const events = document.querySelectorAll('.event');
  events.forEach((event, index) => {
    // Put a microphone on each event listenning for a hover event
    event.addEventListener('mouseenter', () => {
      // Here we trigger the display of the corresponding marker infoWindow as it is the default behavior of a click on a  marker
      google.maps.event.trigger(mapMarkers[index], 'click');
    });
  });

  const styles = [ {
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
    } ];

  map.addStyle({
    styles: styles,
    mapTypeId: 'map_style'
  });
  map.setStyle('map_style');
}

import { autocomplete } from '../components/autocomplete';

autocomplete();
