class PlayersController < UITableViewController

  def initWithStyle(style)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Leaderboard", image: UIImage.imageNamed("players.png"), tag: 1)

    self
  end

  def viewDidLoad
    @spinner = Spin.new(self.view)
    @players = []
    view.dataSource = view.delegate = self

    Latter::API.new.get("/players.json") do |response|
      @spinner.stop
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_s)
        @players = json.map { |player_hash| Player.new(player_hash) }
        view.reloadData
      else
        App.alert(response.error_message)
      end
    end
  end


  def viewWillAppear(animated)
    navigationItem.title = 'Leaderboard'
    @refresh_button = RefreshButton.new(self, "viewDidLoad")
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @players.size
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    PlayerCell.heightForPlayer(@players[indexPath.row], tableView.frame.size.width)
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    player = @players[indexPath.row]
    PlayerCell.cellForPlayer(player, inTableView:tableView)
  end

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath:indexPath)
    player = @players[indexPath.row]
    navigationController.pushViewController(PlayerController.alloc.initWithPlayer(player), animated: true)
  end

  def reloadRowForPlayer(player)
    row = @players.index(player)
    if row
      view.reloadRowsAtIndexPaths([NSIndexPath.indexPathForRow(row, inSection:0)], withRowAnimation:false)
    end
  end
end