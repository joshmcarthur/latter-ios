class PlayerNavigationController < UINavigationController
  def init
    @playersController = PlayersController.alloc.initWithStyle(UITableViewStylePlain)
    self.initWithRootViewController(@playersController)
    self.wantsFullScreenLayout = true
    self.toolbarHidden = true

    self
  end
end
