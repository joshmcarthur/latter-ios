class ChallengeNavigationController < UINavigationController
  def init
    @challengesController = ChallengesController.alloc.initWithStyle(UITableViewStyleGrouped)
    self.initWithRootViewController(@challengesController)
    self.wantsFullScreenLayout = true
    self.toolbarHidden = true

    self
  end
end
