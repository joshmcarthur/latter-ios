class Player
  attr_reader :id, :name, :rating, :gravatar_url, :game_count
  attr_accessor :gravatar_image

  def initialize(dict)
    @id = dict['id']
    @name = dict['name']
    @rating = dict['rating']
    @gravatar_url = dict['gravatar_url']
    @game_count = dict['game_count']
    @gravatar_image = nil
  end

  def load_gravatar_image
    gravatar_image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(self.gravatar_url))
    self.gravatar_image = UIImage.alloc.initWithData(gravatar_image_data)
  end
end
