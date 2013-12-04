require 'data_mapper'

class Tag
    include DataMapper::Resource

    property :tag, String, :key => true

    has n, :task_tag
    has n, :task, :through => :task_tag

    def to_hash
        { :tag => tag }
    end
end

class TaskTag
    include DataMapper::Resource

    belongs_to :task, :key => true
    belongs_to :tag,  :key => true
end
