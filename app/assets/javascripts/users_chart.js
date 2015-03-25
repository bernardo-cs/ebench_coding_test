var app = angular.module('tweetRank', ['angularCharts']);

app
.factory('Users', ['$http', '$q', function($http, $q){

  var users = [];

  return{
    get: function(){
      if (users.length) {
        var deferred = $q.defer();
        deferred.resolve(users);
        return deferred.promisse;
      }
      return $http.get('/users/index.json').then(function(resp) { return resp.data; });
    }
  }
}])
.controller('MainCtrl', ['$scope', 'Users', function($scope, Users) {
  $scope.config = {
    title: 'Retweets',
    tooltips: true,
    labels: false,
    mouseover: function() {},
    mouseout: function() {},
    click: function() {},
    legend: {
      display: true,
      position: 'right'
    }
  };

  $scope.data = {};

  Users.get().then(function(users){
    $scope.data = {
      series: ['Retweets'],
      data: _.map( users, function (el) {
        return { x: el["username"], y: [el["mentions_count"]] };
      } )} 
  });
}]);

