(function() {
    'use strict';

    var tasks = angular.module('tasks', []);

    tasks.controller('TasksCtrl', [
        '$scope',
        function($scope) {
            $scope.title = '';
            $scope.tasks = [];

            function saveTask(task) {
                $scope.tasks.push({
                    task: task,
                    time: new Date()
                });
            }

            $scope.addTask = function() {
                if ($scope.title) {
                    saveTask($scope.title);
                    $scope.title = '';
                }
            };
        }
    ]);
}());
