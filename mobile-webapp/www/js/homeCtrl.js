angular.module('starter')
.controller("homeCtrl", function($scope, $rootScope, $state, Directions) {
    $rootScope.hideNavBar = true;
    $scope.goToType = function() {
        if (!$scope.result)
            return;
        Directions.destination = $scope.result;
        $state.go("navigationType");
    }

    // $scope.where = "rue jeanne d'arc Lyon"

    var geocoder = new google.maps.Geocoder();
    $scope.$watch("where", function(address) {
        console.log(address);
        if (!address || address.length < 3)
            return;
        geocoder.geocode( {'address': address}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                $scope.result = results[0]
                $scope.$apply();
            }
        });
    })



})
