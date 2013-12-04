require 'data_mapper'
require './models/task'
require './models/tag'

DataMapper.setup(:default, 'sqlite3:///home/jeremy/projects/jruby/try_sinatra/test.db')
DataMapper.finalize
#Task.auto_migrate! # Needed on first run
