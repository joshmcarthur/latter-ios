class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    App::Persistence['api_endpoint'] = 'https://latter.herokuapp.com' unless App::Persistence['api_endpoint']
    App::Persistence['api_version'] = 'v1' unless App::Persistence['api_version']

    @player_navigation_controller = PlayerNavigationController.alloc.init
    @challenges_navigation_controller = ChallengeNavigationController.alloc.init

    @tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    @tab_controller.viewControllers = [@player_navigation_controller, @challenges_navigation_controller] #, games_controller]

    if App::Persistence["auth_token"].nil?

      @window.rootViewController = UINavigationController.alloc.initWithRootViewController(
        AuthTokenController.alloc.initWithForm(AuthKeyController.build_form, callbackTo: @tab_controller)
      )
      @window.makeKeyAndVisible
      return true
    end

    @window.rootViewController = @tab_controller
    @window.makeKeyAndVisible

    true
  end
end
