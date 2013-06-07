describe "Player model" do
  def player_hash
    Fixture.load("player.json")
  end

  before do
    @player = Player.new(player_hash)
  end

  it "should set the ID" do
    @player.id.should.equal player_hash['id']
  end

  it "should set the name" do
    @player.name.should.equal player_hash['name']
  end

  it "should set the game count" do
    @player.game_count.should.equal player_hash['game_count']
  end

  it "should set the rating" do
    @player.rating.should.equal player_hash['rating']
  end

  it "should set the gravatar image URL" do
    @player.gravatar_url.should.equal player_hash['gravatar_url']
  end

  it "should default gravatar image to nil" do
    @player.gravatar_image.should.equal nil
  end

  it "should set the gravatar image when load_gravatar_image is called" do
    @player.load_gravatar_image
    wait 1.0 do
      @player.gravatar_image.class.should.not.be.nil
    end
  end
end

