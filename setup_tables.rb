require 'data_mapper'
require './models/task'

update_db
task = Task.create(
    :title => 'Get the database working',
    :create_time => Time.now,
)
task.save
