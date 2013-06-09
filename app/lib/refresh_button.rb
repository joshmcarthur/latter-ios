class RefreshButton
  attr_accessor :button

  def initialize(controller, action)
    @controller = controller
    @action     = action
    @button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
                    UIBarButtonSystemItemRefresh,
                    target: self,
                    action: "performRefresh"
                  )
    @controller.navigationItem.rightBarButtonItem = self.button

    self
  end

  def performRefresh
    @button.enabled = false
    @controller.send(@action)
    @button.enabled = true
  end
end

