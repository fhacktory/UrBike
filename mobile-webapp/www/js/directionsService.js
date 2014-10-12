angular.module('starter')
.service("Directions", function() {
    this.destination = null;

    this.directionsService = new google.maps.DirectionsService();

    return this;
});
