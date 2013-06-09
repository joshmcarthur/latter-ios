describe 'Game model' do
  # A game between Mike and Josh, Mike won 21-19
  def game_hash
    Fixture.load("games.json").first
  end

  before do
    @game = Game.new(game_hash)
  end

  it "should set the challenger" do
    @game.challenger.should.not.be.nil
  end

  it "should assign the correct player to challenger" do
    @game.challenger.name.should.equal "Mikaere"
  end

  it "should set the challenged" do
    @game.challenged.should.not.be.nil
  end

  it "should assign the correct player to challenged" do
    @game.challenged.name.should.equal "Josh"
  end

  it "should set the winner" do
    @game.winner.should.equal @game.challenger
  end

  it "should set the score string" do
    @game.score_string.should.equal game_hash['score']
  end
end
