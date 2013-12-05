require 'rubygems'
require 'sinatra'
require 'haml'
require 'json'

require './rpn'
require './models/models'

require './views/tasks'
require './views/euler'

require './actions/tasks'

get '/migrate' do
    Tag.auto_migrate!
    TaskTag.auto_migrate!
    'done'
end

get '/hi' do
    haml :hi
end

get '/hello/:name' do |name|
    haml :hello, :locals => {:name => name}
end

def render_nav(solutions)
    haml :euler_nav, :locals => {
        :solved => solutions.keys,
    }
end

get %r{/euler/(\d+)} do |problem|
    template, values = EulerView.new.render(problem)
    haml template, :locals => values
end

get '/rpn' do
    render_rpn
end

post '/rpn' do
    answer = eval_rpn params[:expression]
    render_rpn answer
end

def render_rpn(answer=nil)
    haml :rpn, :locals => {
        :answer => answer,
    }
end

get '/tasks' do
    template, values = TasksView.new.render
    haml template, :locals => values
end

post '/tasks' do
    content_type :json
    AddTaskAction.new.act(params[:task]).to_json
end

post '/tasks/complete' do
    content_type :json
    CompleteAction.new.act(params[:task_id]).to_json
end

get '/tasks/tag/:tag_name' do |tag_name|
    tasks = Task.all(
        :done_time => nil,
        :task_tag => {tag_tag: tag_name},
        :order => [ :create_time.asc ]
    )
    tasks_json = (tasks.map { |task| task.to_hash }).to_json

    completed_count = Task.count(:done_time.not => nil, :task_tag => {:tag_tag => tag_name})

    haml :tasks_tag, :locals => {
        :tag_name => tag_name,
        :tasks => tasks_json,
        :completed => completed_count,
    }
end
