require 'sinatra'
require 'haml'
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
    haml :tasks, :locals => {
        :tasks => Task.all,
    }
end

post '/tasks' do
    task = Task.create(
        :title => params[:task],
        :create_time => Time.now,
    )
    task.save

    redirect to('/tasks')
end
