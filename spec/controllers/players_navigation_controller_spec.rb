describe "Players navigation controller" do
  extend WebStub::SpecHelpers
  before do
    @controller = PlayerNavigationController.alloc.init
  end


  it "inherits from UINavigationController" do
    @controller.superclass.should.equal UINavigationController
  end

  it "sets the players controller as it's root view controller" do
    @controller.viewControllers.first.class.should.equal PlayersController
  end
end