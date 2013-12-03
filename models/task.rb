require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'sqlite3::memory:')

class Task
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :create_time, DateTime
end

Task.auto_migrate!
