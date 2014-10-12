// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
angular.module('starter', ['ionic', 'google-maps'.ns()])
.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('index', {
    url: '/',
    templateUrl: 'home.html',
    controller: 'homeCtrl'
  })
  .state('navigationType', {
    url: '/type',
    templateUrl: 'navigationType.html',
    controller: 'typeCtrl'
  })
  .state('navigation', {
    url: '/navigation',
    templateUrl: 'navigation.html',
    controller: 'navigationCtrl'
  })

  $urlRouterProvider.otherwise("/");

})
.config(['GoogleMapApiProvider'.ns(), function (GoogleMapApi) {
  GoogleMapApi.configure({
    //    key: 'your api key',
    v: '3.17',
    libraries: 'weather,geometry,visualization',
    sensor: true
  });
}])
.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      StatusBar.styleDefault();
    }
  });
})
