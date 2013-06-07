
class Fixture
  def self.load(filename)
    file = File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', filename), 'r')
    case File.extname(file)
    when ".json"
      BubbleWrap::JSON.parse(file.read)
    else
      file.read
    end
  end
end