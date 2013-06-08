describe "Application 'latter'" do
  before do
    App::Persistence['auth_token'] = nil
    @app = UIApplication.sharedApplication
  end

  it "has a root view controller" do
    @app.windows.first.rootViewController.should.not.be.nil
  end

  it "sets a default API endpoint using HTTPS" do
    App::Persistence['api_endpoint'].should.match /\Ahttps\:\/\//
  end

  it "uses v1 of the Latter API" do
    App::Persistence['api_version'].should.equal 'v1'
  end

  it "does not set an auth token by default" do
    App::Persistence['auth_token'].should.be.nil
  end
end

# FIXME I don't think Bacon is clearing state between describe blocks
# as it should
# describe "Application 'latter' with no auth token set" do
#   before do
#     App::Persistence['auth_token'] = nil
#     @app = UIApplication.sharedApplication
#   end

#   it "sets an instance of AuthKeyController as the root view" do
#     @app.windows.first.rootViewController.viewControllers.first.class.should.equal AuthKeyController
#   end
# end

describe "Application 'latter' with an auth token set" do
  before do
    App::Persistence['auth_token'] = 'testing'
    @app = UIApplication.sharedApplication
  end

  it "sets an instance of UITabBarController as the root view" do
    @app.windows.first.rootViewController.class.should.equal UITabBarController
  end

  def tabBarControllers
    @app.windows.first.rootViewController.viewControllers.map(&:class)
  end

  it "adds the players navigation controller to the tab" do
    tabBarControllers.should.include PlayerNavigationController
  end

  it "adds the challenges navigation controller to the tab" do
    tabBarControllers.should.include ChallengeNavigationController
  end

end
