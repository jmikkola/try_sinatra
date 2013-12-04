require 'sinatra'
require 'haml'
require 'json'

require './euler'
require './rpn'
require './models/task'

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
    solutions = {
        1 => euler_1,
        2 => euler_2,
        3 => euler_3,
        4 => euler_4,
        5 => euler_5,
    }

    locals = {
        :prob_no => problem,
        :nav => render_nav(solutions),
    }

    prob_num = Integer(problem)
    if solutions.has_key?(prob_num)
        locals[:answer] = solutions[prob_num]
        template = :project_euler
    else
        template = :no_solution
    end

    haml template, :locals => locals
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
    tasks = Task.all(:done_time => nil, :order => [ :create_time.asc ])
    tasks_json = (tasks.map { |task| task.to_hash }).to_json

    haml :tasks, :locals => {
        :tasks => tasks_json,
    }
end

post '/tasks' do
    content_type :json
    title = params[:task]

    if title
        task = Task.create(
            :title => params[:task],
            :create_time => Time.now,
        )
        task.save

        {:success => true, :task => task.to_hash}.to_json
    else
        {:success => false, :error => "No task title given"}.to_json
    end
end

post '/tasks/complete' do
    content_type :json
    task_id = params[:task_id]

    task = Task.get(task_id)
    if task.nil?
        return {:success => false, :error => 'Task not found'}
    end

    task.done_time = Time.now
    task.save

    {:success => true}.to_json
end
