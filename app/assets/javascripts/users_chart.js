angular.module('tweetRank', ['angularCharts']);

angular.module('tweetRank', ['angularCharts'])
.factory('Users', ['$http', function( $http ){
  var users =[];

  //$scope.getUsersFromServer = function(){
    //$http.get('/users/index.json').success(function(data, status, headers, config) {
      //$scope.users = data;
    //})
  //}

  return {
    get: function(){
      return users;
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
      //could be 'left, right'
      position: 'right'
    }
  };

  $scope.users = Users.get();

  $scope.data = {
    series: ['Retweets'],
    data: _.map( $scope.users, function (el) {
      return { x: el["username"], y: [el["retweets_count"]] };
    } ) 
  };

}]);

