require './models/task'
require './models/models'

describe :parse_task do
    it 'should give back title w/o tags unchanged' do
        description = "a title that doesn't have tags"
        result = parse_task(description)

        expect(result[:task]).to eq(description)
        expect(result[:tags].length).to eq(0)
    end

    it 'should take tags from anywhere' do
        description = "[first111] some text [here] and [there]"
        result = parse_task(description)

        expect(result[:task]).to eq("some text  and")
        expect(result[:tags]).to eq(['first111', 'here', 'there'])
    end
end

describe Task do
    it 'should convert to hash properly' do
        connect_for_test()
        task = Task.new(:title => 'a title here')
        task.add_tags(['a', 'tag'])
        h = task.to_hash()

        expect(h[:title]).to eq('a title here')
        expect(h[:create_time].nil?).to eq(false)
        expect(h[:done_time].nil?).to eq(true)
        expect(h[:tags]).to eq([{:tag => 'a'}, {:tag => 'tag'}])
    end
end
