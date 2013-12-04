require 'data_mapper'

class Task
    include DataMapper::Resource

    property :id, Serial
    property :title, String, :required => true
    property :create_time, DateTime, :required => true, :default => lambda { |r, p| Time.now }
    property :done_time, DateTime

    has n, :task_tag
    has n, :tag, :through => :task_tag

    def add_tags(tag_array)
        tag_array.each do |tag_name|
            tag << Tag.get_or_create(tag_name)
        end
    end

    def to_hash
        tag_hashes = tag.map { |tag| tag.to_hash }

        {
            :id => id,
            :title => title,
            :create_time => create_time,
            :done_time => done_time,
            :tags => tag_hashes,
        }
    end
end

def parse_task(description)
    tag_re = /\[\w+\]/
    tags = description.scan(tag_re).map { |tag| tag.tr '[]', '' }
    title = description.gsub(tag_re, '')
    return { :task => title, :tags => tags }
end
