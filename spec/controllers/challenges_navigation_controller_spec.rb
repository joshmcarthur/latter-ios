describe "Challenge navigation controller" do
  before do
    @controller = ChallengeNavigationController.alloc.init
  end


  it "inherits from UINavigationController" do
    @controller.superclass.should.equal UINavigationController
  end

  it "sets the challenges controller as it's root view controller" do
    @controller.viewControllers.first.class.should.equal ChallengesController
  end
end