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
