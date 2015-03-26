var app = angular.module('tweetRank', ['nvd3']);

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
  $scope.options = {
            chart: {
                type: 'discreteBarChart',
                height: 450,
                width: 600,
                margin : {
                    top: 20,
                    right: 20,
                    bottom: 60,
                    left: 55
                },
                x: function(d){return d.label;},
                y: function(d){return d.value;},
                showValues: true,
                valueFormat: function(d){
                    return d[0];
                },
                transitionDuration: 500,
                xAxis: {
                    axisLabel: 'X Axis'
                },
                yAxis: {
                    axisLabel: 'Y Axis',
                    axisLabelDistance: 30
                }
            }
        };

  $scope.data =  [];

  Users.get().then(function(users){
    $scope.data = [{
      key: "Mentions Count",
      values: _.map( users, function (el) {
        console.log( users );
        return { label: el["username"], value: [el["mentions_count"]] };
      } )
    }] 
  });
}]);

