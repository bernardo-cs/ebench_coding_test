angular.module('tweetRank', ['nvd3', 'infinite-scroll'])
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
                    axisLabel: 'Twitter handler'
                },
                yAxis: {
                    axisLabel: 'Number of retweets',
                    axisLabelDistance: 30
                }
            }
        };

  $scope.data =  [];

  Users.get().then(function(users){
    $scope.data = [{
      key: "Mentions Count",
      values: _.map( users, function (el) {
        return { label: el["username"], value: [el["mentions_count"]][0] };
      } )
    }]
  });
}]).
  factory('Tweets', ['$http', function ($http) {

  var Tweets = function ( query, sort ) {
    this.items = [];
    this.busy = false;
    this.current_page = 1;
    this.sort = sort;
    this.query = query;
    this.done = false;
  }

  Tweets.prototype.search = function ( query, sort ) {
    this.query = query;
    this.sort = sort;
    this.items = [];
    this.done = false;
    this.current_page = 1;
  }

  Tweets.prototype.nextPage = function () {
    if ( this.busy ) return;
    this.busy = true;

    var url = '/tweets/search.json?q=' + this.query + '&sort=' + this.sort + '&page=' + this.current_page;
    $http.get(url).then( function (response) {
      console.log( response );
      var items = response.data;

      if( items.length > 0 ){
        for (var i = 0; i < items.length; i++) {
          this.items.push(items[i]);
        } 
        this.current_page++;
      }else{
        this.done = true;
      }
      this.busy = false;
    }.bind(this) );
  };

  return Tweets;
}]).
  controller('TweetsPaginationCtrl', ['$scope', 'Tweets', function ($scope, Tweets) {

  var get_params = function ( url ) {
    return _.rest(_.map(url.split('&'), function(el){ 
      return { param: el.split('=')[0], value: el.split('=')[1] };
    }));
  }

  var get_param = function (params, param) {
    return _.where(params, { param: param})[0]['value'];
  }

  var search_query = get_param(get_params(window.location.href), "q" ); 
  var sort_type = get_param( get_params( window.location.href ), "sort" );

  $scope.tweetsSearchText = search_query;
  $scope.tweets = new Tweets( search_query, sort_type );
  $scope.sort = $scope.tweets.sort;

  $scope.tweetsSearch = function () {
    $scope.tweets.search( $scope.tweetsSearchText, $scope.sort );
    $scope.tweets.nextPage();
  }
}]);
