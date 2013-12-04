(function() {
    'use strict';

    var tasks = angular.module('tasks', []);

    tasks.controller('TasksCtrl', [
        '$scope', '$http',
        function($scope, $http) {
            $scope.title = '';
            $scope.tasks = [];

            function saveTask(task) {
                $scope.tasks.push({
                    task: task,
                    time: new Date()
                });

                $http({
                    url: '/tasks',
                    method: 'POST',
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    data: $.param({task: task})
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
