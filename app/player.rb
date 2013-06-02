class Player
  attr_reader :name, :rating, :gravatar_url
  attr_accessor :gravatar_image

  def initialize(dict)
    @name = dict['name']
    @rating = dict['rating']
    @gravatar_url = dict['gravatar_url']
    @gravatar_image = nil
  end
end
