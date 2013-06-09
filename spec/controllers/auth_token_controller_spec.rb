describe "auth token controller" do
  extend WebStub::SpecHelpers


  before do
    disable_network_access!
    self.controller = AuthTokenController.alloc.initWithForm(AuthTokenController.build_form, callbackTo: nil)
  end

  after do
    NSUserDefaults.resetStandardUserDefaults
    NSUserDefaults.standardUserDefaults
  end


  tests AuthTokenController

  it "sets the navigation item title" do
    controller.navigationItem.title.should.equal "Access Credentials"
  end

  it "adds a save button" do
    controller.navigationItem.rightBarButtonItem.class.should.equal UIBarButtonItem
  end

  it "has an auth token field" do
    view("Auth Token").should.not.be.nil
  end

  it "has a Latter URL field" do
    view("Latter URL").should.not.be.nil
  end

  it "displays an alert when auth token is left blank" do
    controller.form.stub!(:render, :return => {"auth_token" => "", "api_endpoint" => "https://testing.com"})
    App.mock!(:alert, :return => nil) { |message| message.should.equal "Auth token must not be blank!" }
    controller.submit
  end

  it "displays an alert when Latter URL is not a URL" do
    controller.form.stub!(:render, :return => {"api_endpoint" => "not a url" })
    App.mock!(:alert, :return => nil) { |message| message.should.equal "API Endpoint must be a URL" }
    controller.submit
  end

  it "displays an alert when the auth token is not recognized" do
    stub_request(:get, "https://testing.com/player.json?auth_token=testing").
      to_return(status_code: 401)

    controller.form.stub!(:render, :return => {"auth_token" => "testing", "api_endpoint" => "https://testing.com" })
    App.mock!(:alert, :return => nil) { |message| message.should.equal "Auth key was not valid, please try again." }

    controller.submit
    proper_wait 1.0
  end

  it "sets the current player ID and auth token when the auth token is recognized and presents the callback controller" do
    stub_request(:get, "https://testing.com/player.json?auth_token=testing").
      to_return(json: Fixture.load("player.json"), status_code: 200)

    controller.form.stub!(:render, :return => {"auth_token" => "testing", "api_endpoint" => "https://testing.com" })
    controller.mock!('presentViewController:animated:completion', :return => nil) do |controller, animated, completion|
    end

    controller.submit
    proper_wait 1.0

    App::Persistence['auth_token'].should.equal "testing"
    App::Persistence['current_player_id'].should.equal 1
  end

end