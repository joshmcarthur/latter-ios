describe "Challenge navigation controller" do
  extend WebStub::SpecHelpers
  before do
    stub_request("#{App::Persistence['api_endpoint']}/games.json?auth_token=testing&complete=false").
      to_return(json: [])
    self.controller = ChallengeNavigationController.alloc.init
  end

  tests ChallengeNavigationController

  it "inherits from UINavigationController" do
    self.controller.superclass.should.equal UINavigationController
  end

  # it "sets the challenges controller as it's root view controller" do
  #   self.controller.viewControllers.first.class.should.equal ChallengesController
  # end
end