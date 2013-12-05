require 'json'

class TasksView
    def render
        return :tasks, values
    end

    def values
        { :tasks => get_tasks.to_json, :completed => count_completed }
    end

    def get_tasks
        tasks = Task.all(
            :done_time => nil,
            :order => [ :create_time.asc ],
        )
        return tasks.map { |task| task.to_hash }
    end

    def count_completed
        Task.count(:done_time.not => nil)
    end
end

class TaskTagView
    def initialize(tag_name)
        @tag_name = tag_name
    end

    def render
        return :tasks_tag, values
    end

    def values
        { :tasks => get_tasks.to_json, :completed => count_completed, :tag_name => @tag_name }
    end

    def get_tasks
        tasks = Task.all(
            :done_time => nil,
            :task_tag => {:tag_tag => @tag_name},
            :order => [ :create_time.asc ],
        )
        return tasks.map { |task| task.to_hash }
    end

    def count_completed
        Task.count(:done_time.not => nil, :task_tag => {:tag_tag => @tag_name})
    end
end
