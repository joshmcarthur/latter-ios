describe "Challenge navigation controller" do
  extend WebStub::SpecHelpers
  before do
    disable_network_access!
    self.controller = ChallengeNavigationController.alloc.init
  end

  tests ChallengeNavigationController

  it "inherits from UINavigationController" do
    controller.superclass.should.equal UINavigationController
  end

  it "sets the challenges controller as it's root view controller" do
    controller.viewControllers.first.class.should.equal ChallengesController
  end
end