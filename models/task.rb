require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'sqlite3:///tmp/tasks.db')

class Task
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :create_time, DateTime
end

def update_db
    DataMapper.auto_upgrade!
end
