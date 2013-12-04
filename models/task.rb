require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'sqlite3:///home/jeremy/projects/jruby/try_sinatra/test.db')

class Task
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :create_time, DateTime
    property :done_time, DateTime

    def to_hash
        { :id => id, :title => title, :create_time => create_time, :done_time => done_time }
    end
end

DataMapper.finalize
#Task.auto_migrate! # Needed on first run
