angular.module('starter')
.controller("navigationCtrl", function($scope, uiGmapIsReady, Directions, $state, $interval, $timeout) {

    if (!Directions.destination)
        return $state.go("index");
    $scope.destination = {
        latitude: Directions.destination.geometry.location.lat(),
        longitude: Directions.destination.geometry.location.lng()
    };

    navigator.geolocation.getCurrentPosition(function(location) {
        $scope.map.center = {
            latitude: location.coords.latitude,
            longitude: location.coords.longitude
        };
        $scope.ownPosition = {
            latitude: location.coords.latitude,
            longitude: location.coords.longitude
        };
        $scope.$apply();
        // navigator.geolocation.watchPosition(changePosition);

        var request = {
            origin: new google.maps.LatLng($scope.ownPosition.latitude, $scope.ownPosition.longitude),
            destination: new google.maps.LatLng($scope.destination.latitude, $scope.destination.longitude),
            travelMode: google.maps.TravelMode.BICYCLING
        };
        Directions.directionsService.route(request, function(result, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                console.log(result);
                $scope.path = result.routes[0].overview_path;
                $scope.directions = result.routes[0];
                $scope.$apply();
            }
        });
    });

    function changePosition(location) {
        $scope.map.center = {
            latitude: location.coords.latitude,
            longitude: location.coords.longitude
        };
        $scope.ownPosition = {
            latitude: location.coords.latitude,
            longitude: location.coords.longitude
        };
        $scope.$apply();
    }

    function getCurrentStep() {
        if (!$scope.directions)
            return null;
        for (var i = 0; i < $scope.directions.legs[0].steps.length; i++) {
            if (!$scope.directions.legs[0].steps[i].old)
                return $scope.directions.legs[0].steps[i];
        };
        return null;
    }

    var vibrateInterval = undefined;
    var vibrateType = undefined;

    var vibrate = {
        left: function() {
            if (vibrateType !== "left")
                vibrate.reset()
            else if (vibrateType === "left")
                return;
            vibrateType = "left";
            if (angular.isDefined(vibrateInterval))
                return;
            vibrateInterval = $interval(function() {
                navigator.vibrate(1000);
                $scope.vibrating = true;
                $timeout(function() {$scope.vibrating = false}, 1000);
            }, 2000);
        },
        right: function() {
            if (vibrateType !== "right")
                vibrate.reset()
            else if (vibrateType === "right")
                return;
            vibrateType = "right";
            if (angular.isDefined(vibrateInterval))
                return;
            vibrateInterval = $interval(function() {
                navigator.vibrate(2000);
                $scope.vibrating = true;
            }, 2000);
        },
        reset: function() {
            vibrateType = undefined;
            $scope.vibrating = false;
            $interval.cancel(vibrateInterval);
            vibrateInterval = undefined;
        }
    }

    function updateNavigation() {
        var currentStep = getCurrentStep();
        if (!currentStep)
            return;
        var distance = google.maps.geometry.spherical.computeDistanceBetween(currentStep.start_location,
            new google.maps.LatLng($scope.ownPosition.latitude, $scope.ownPosition.longitude));
        if (distance < 25)
            currentStep.old = true;
        else
        {
            $scope.distanceToStep = distance;
            var maneuver = currentStep.maneuver.split('-');
            maneuver = maneuver[maneuver.length - 1];
            if (maneuver != 'left' && maneuver != 'right')
                return currentStep.old = true;
            $scope.step = maneuver;
            $scope.distance = distance;
            if (distance < 75)
                vibrate[maneuver]()
            else
                vibrate.reset()
        }
    }

    $scope.draggableMarker = {
        draggable: true
    }

    $scope.mapevent = {
        'drag': function(map) {
            // console.log("center changed");
            // var center = map.getCenter();
            // console.log(center);
            // $scope.ownPosition = {
            //     latitude: center.lat(),
            //     longitude: center.lng()
            // };

        }
    }

    $interval(updateNavigation, 500);

    $scope.ownPosition = {
        latitude: 47,
        longitude: 10
    }

    $scope.gmap = {};
    $scope.map = {
        center: {
            latitude: 47,
            longitude: 10
        },
        zoom: 15
    };
})
