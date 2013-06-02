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

    nav = UINavigationController.alloc.initWithRootViewController(root_controller)
    nav.wantsFullScreenLayout = true
    nav.toolbarHidden = true
    @window.rootViewController = nav
    @window.makeKeyAndVisible
    true
  end
end
