require './models/models'
require './actions/tasks'

describe AddTaskAction do
    it "should handle no title" do
        connect_for_test()
        add_task_action = AddTaskAction.new
        result = add_task_action.act('')

        expect(result[:success]).to eq(false)
        expect(result[:error].length).to be > 1
    end

    it "should add a task" do
        connect_for_test()
        add_task_action = AddTaskAction.new
        result = add_task_action.act('my task')

        expect(result[:success]).to eq(true)
        expect(result[:task][:title]).to eq('my task')

        all_tasks = Task.all()
        expect(all_tasks.length).to eq(1)
        expect(all_tasks[0].title).to eq(result[:task][:title])
        expect(all_tasks[0].id).to eq(result[:task][:id])
    end

    it "should parse tags" do
        connect_for_test()
        add_task_action = AddTaskAction.new
        result = add_task_action.act('[tag1] [tag2] task with tags')

        expect(result[:success]).to eq(true)
        expect(result[:task][:title]).to eq('task with tags')
        expect(result[:task][:tags].length).to eq(2)

        all_tasks = Task.all()
        expect(all_tasks.length).to eq(1)
        expect(all_tasks[0].tag.length).to eq(2)
    end
end

def setup
    connect_for_test()
    task = Task.create(:title => 'testing task')
    task.save()
    return task, CompleteAction.new
end

describe CompleteAction do
    it 'should give error for missing id' do
        task, action = setup()
        result = action.act(task.id + 1000)

        expect(result[:success]).to eq(false)
        expect(result[:error].length).to be > 1
    end

    it 'should add task complete time' do
        task, action = setup()
        result = action.act(task.id)
        all_tasks = Task.all()

        expect(result[:success]).to eq(true)
        expect(all_tasks[0].create_time.nil?).to eq(false)
    end
end
