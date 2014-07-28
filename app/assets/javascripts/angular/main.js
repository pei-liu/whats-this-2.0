
(function(){
  var app = angular.module("completedGames", []);


  app.controller("completedCtrl", [ '$scope', '$http', '$sce', function($scope, $http, $sce){
    $scope.games = [];
    $scope.activeGame = [];

    // for rendering svg as html
    $scope.renderHTML = function(htmlCode) {
      return $sce.trustAsHtml(htmlCode);
    };

    $scope.roundWrapper = function(htmlCode, type) {
      if(type==="drawing") {
        html = '<div class="square-svg-container">'
        html += '<a href="#" data-toggle="modal" data-target="#completedGameModal">'
        html += htmlCode
        html += '</a></div>'
        return html
      } else {
        html = '<div class="completed-square-description-container">'
        html += '<a href="#" data-toggle="modal" data-target="#completedGameModal">'
        html += '<div class="completed-description-container-table">'
        html += '<div class="completed-description-container-table-cell">'
        html += htmlCode
        html += '</div></div></a></div>'
        return html
      }
    };

    $scope.setActiveGame = function(game) {
      $scope.activeGame = game
    };

    $http.get('/get_completed_games').success(function(data){
      $scope.games = data;
      $scope.activeGame = data[0].rounds;
    })

  }])
})();






