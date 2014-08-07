angular.module('panels', []).

controller("PanelCtrl", [ '$scope', '$http', '$sce', function($scope, $http, $sce){
    $scope.tab = 1;

    $scope.selectTab = function(setTab){
        $scope.tab = setTab;
    };

    $scope.isSelected = function(checkTab){
        return $scope.tab === checkTab
    };
}]);