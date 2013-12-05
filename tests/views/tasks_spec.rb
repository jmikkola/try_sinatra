require 'json'

require './models/models'
require './views/tasks'

describe TasksView do
    connect_for_test()

    it "should render" do
        tasks_view = TasksView.new
        template, values = tasks_view.render

        expect(template).to eq(:tasks)
        expect(values[:tasks]).to eq([].to_json)
        expect(values[:completed]).to eq(0)
    end
end

describe TaskTagView do
    connect_for_test()

    it "should render" do
        task_tag_view = TaskTagView.new('lolcatz')
        template, values = task_tag_view.render

        expect(template).to eq(:tasks_tag)
        expect(values[:tasks]).to eq([].to_json)
        expect(values[:completed]).to eq(0)
        expect(values[:tag_name]).to eq('lolcatz')
    end
end
