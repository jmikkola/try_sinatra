(function() {
    'use strict';

    var tasks = angular.module('tasks', []);

    tasks.factory('post', [
        '$http', function($http) {
            function post(url, data, onSuccess, onError) {
                var options = {
                    url: url,
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    data: $.param(data)
                };

                $http(options).success(onSuccess).error(onError);
            }

            return post;
        }
    ]);

    tasks.controller('TasksCtrl', [
        '$scope', 'post', 'tasks',
        function($scope, post, tasks) {
            $scope.title = '';
            $scope.tasks = tasks;

            function saveTask(task) {
                function onSuccess(data) {
                    $scope.tasks.push(data.task);
                }

                function onError(data) {
                    var message = 'error';
                    if (data && data.error) {
                        message = data.error;
                    }
                    console.log(data)

                    $scope.title = task;
                    alert(message);
                }

                post('/tasks', {task: task}, onSuccess, onError);
            }

            $scope.addTask = function() {
                if ($scope.title) {
                    saveTask($scope.title);
                    $scope.title = '';
                }
            };
        }
    ]);

    tasks.controller('TaskCtrl', [
        '$scope', 'post',
        function($scope, post) {
            $scope.complete = function() {
                function onSuccess() {
                    $scope.task.done_time = new Date();
                }
                function onError() {
                    alert('error');
                }
                post('/tasks/complete', {task_id: $scope.task.id}, onSuccess, onError);
            };
        }
    ]);
}());
