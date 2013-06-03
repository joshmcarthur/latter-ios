class GamesController < UITableViewController

  def initWithStyle(style)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Games", image: UIImage.imageNamed("games.png"), tag: 2)
    self
  end

  def viewDidLoad
    @games = []
    view.dataSource = view.delegate = self

    Latter::API.new.get("/games") do |response|
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_s)
        @games = json.select { |hash| hash["challenger"] && hash["challenged"] }.map { |game_hash| Game.new(game_hash) }
        view.reloadData
      else
        App.alert(response.error_message)
      end
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    game = @games[indexPath.row]
    GameCell.cellForGame(game, inTableView:tableView)
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    # Arbitrary
    55
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @games.count
  end


end