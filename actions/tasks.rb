require './models/task'

class AddTaskAction
    def act(title)
        if title.length > 0
            task_details = parse_task(title)

            task = Task.create(:title => task_details[:task])
            task.add_tags(task_details[:tags])
            task.save

            return {:success => true, :task => task.to_hash}
        else
            return {:success => false, :error => 'No title given for task'}
        end
    end
end

class CompleteAction
    def act(task_id)
        task = Task.get(task_id)
        if task.nil?
            return {:success => false, :error => 'Task not found'}
        else
            task.done_time = Time.now
            task.save
            return {:success => true}
        end
    end
end
