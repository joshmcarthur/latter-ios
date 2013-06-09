describe "Players navigation controller" do
  extend WebStub::SpecHelpers
  before do
    stub_request(
      :get, "http://#{App::Persistence['api_endpoint']}/players.json?auth_token=#{App::Persistence['auth_token']}"
    ).to_return(json: [])

    self.controller = PlayerNavigationController.alloc.init
  end

  tests PlayerNavigationController

  it "inherits from UINavigationController" do
    self.controller.superclass.should.equal UINavigationController
  end

  it "sets the players controller as it's root view controller" do
    self.controller.viewControllers.first.class.should.equal PlayersController
  end

  it "has a refresh button" do
    view("Refresh Table").class.should.equal UINavigationButton
  end
end