class Player
  attr_reader :name, :rating, :gravatar_url
  attr_accessor :gravatar_image

  def initialize(dict)
    @name = dict['name']
    @rating = dict['rating']
    @gravatar_url = dict['gravatar_url']
    @gravatar_image = nil
  end

  def load_gravatar_image
    gravatar_image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(self.gravatar_url))
    self.gravatar_image = UIImage.alloc.initWithData(gravatar_image_data)
  end
end
