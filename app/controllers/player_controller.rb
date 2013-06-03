class PlayerController < UIViewController

  def initWithPlayer(player)
    @player = player
    self.initWithNibName(nil, bundle: nil)
  end

  def viewDidLoad
    super

    @player_container = PlayerView.alloc.initWithPlayerAndFrame(@player, [[0, 0], [self.view.frame.size.width, self.view.frame.size.height]])
    self.view.addSubview(@player_container)
  end

  def viewWillAppear(animated)
    navigationItem.title = @player.name
  end

end