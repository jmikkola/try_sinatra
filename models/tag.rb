require 'data_mapper'

class Tag
    include DataMapper::Resource

    property :tag, String, :key => true

    has n, :task_tag
    has n, :task, :through => :task_tag

    def to_hash
        { :tag => tag }
    end

    def Tag.get_or_create(tag_name)
        tag = Tag.get(tag_name)
        if tag.nil?
            tag = Tag.create(:tag => tag_name)
        end
        return tag
    end
end

class TaskTag
    include DataMapper::Resource

    belongs_to :task, :key => true
    belongs_to :tag,  :key => true
end
