class PlayersController < UITableViewController

  def viewDidLoad
    @players = []
    view.dataSource = view.delegate = self

    Latter::API.new.get("/players.json") do |response|
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_s)
        @players = json.reverse.map { |player_hash| Player.new(player_hash) }
        view.reloadData
      else
        App.alert(response.error_message)
      end
    end
  end


  def viewWillAppear(animated)
   navigationItem.title = 'Leaderboard'
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