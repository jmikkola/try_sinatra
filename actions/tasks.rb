require './models/task'

class AddTaskAction
    def act(title)
        if title
            task_details = parse_task(title)

            task = Task.create(:title => task_details[:task])
            task.add_tags(task_details[:tags])
            task.save

            {:success => true, :task => task.to_hash}
        else
            {:success => false, :error => 'No title given for task'}
        end
    end
end
