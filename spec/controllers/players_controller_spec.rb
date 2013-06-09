describe 'Players controller' do
  extend WebStub::SpecHelpers

  before do
    stub_request(
      :get, "#{App::Persistence['api_endpoint']}/players.json?auth_token=#{App::Persistence['auth_token']}"
    ).to_return(json: [])

    self.controller = PlayersController.alloc.initWithStyle(UITableViewStylePlain)
  end

  tests PlayersController

  it "sets it's tab bar title" do
    controller.tabBarItem.title.should.equal "Leaderboard"
  end

  it "sets it's navigation controller title" do
    controller.navigationItem.title.should.equal "Leaderboard"
  end
end