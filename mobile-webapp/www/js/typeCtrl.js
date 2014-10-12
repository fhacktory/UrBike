angular.module('starter')
.controller("typeCtrl", function($scope, $rootScope, $state) {
    $rootScope.hideNavBar = false;
    $scope.goToNavigation = function() {
        if (!$scope.type)
            return;
        $state.go("navigation");
    }
})
