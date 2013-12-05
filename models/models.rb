require 'data_mapper'
require './models/task'
require './models/tag'

def get_default_db_spec
    return 'sqlite3:///' + Dir.pwd + '/test.db'
end

def connect_and_finalize(db_spec)
    DataMapper.setup(:default, db_spec)
    DataMapper.finalize()
end

def default_connect_and_finalize
    connect_and_finalize(get_default_db_spec())
end

def connect_for_test
    DataMapper.setup(:default, 'sqlite3::memory:')
    DataMapper.auto_migrate!
    DataMapper.finalize()
end
