class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    App::Persistence['api_endpoint'] = 'https://latter.herokuapp.com' unless App::Persistence['api_endpoint']
    App::Persistence['api_version'] = 'v1' unless App::Persistence['api_version']

    if App::Persistence["auth_token"].nil?
      root_controller = AuthKeyController.alloc.initWithForm(AuthKeyController.build_form)
    else
      root_controller = PlayersController.alloc.initWithStyle(UITableViewStylePlain)
    end

    # games_controller = GamesController.alloc.initWithStyle(UITableViewStylePlain)
    challenges_controller = ChallengesController.alloc.initWithStyle(UITableViewStyleGrouped)

    player_navigation_controller = UINavigationController.alloc.initWithRootViewController(root_controller)
    player_navigation_controller.wantsFullScreenLayout = true
    player_navigation_controller.toolbarHidden = true

    challenge_navigation_controller = UINavigationController.alloc.initWithRootViewController(challenges_controller)
    challenge_navigation_controller.wantsFullScreenLayout = true
    challenge_navigation_controller.toolbarHidden = true

    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    tab_controller.viewControllers = [player_navigation_controller, challenge_navigation_controller] #, games_controller]
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible
    true
  end
end
