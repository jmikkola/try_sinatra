require 'data_mapper'
require './models/task'
require './models/tag'

db_path = Dir.pwd + '/test.db'
DataMapper.setup(:default, 'sqlite3:///' + db_path)
DataMapper.finalize
#Task.auto_migrate! # Needed on first run
