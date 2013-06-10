class ScoreController < UITableViewController

  def initWithGame(game)
    @game = game
    self.initWithStyle(UITableViewStyleGrouped)
  end

  def viewWillAppear(animated)
    navigationItem.title = 'Enter Score'
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
  end

  def tableView(tableView, numberOfRowsInSection:indexPath)
    2 # Challenger and Challenged
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    64 + 10
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    case indexPath.row
    when 0
      @challenger_row = ScoreEntryCell.cellForPlayer(@game.challenger, inTableView: tableView)
    when 1
      @challenged_row = ScoreEntryCell.cellForPlayer(@game.challenged, inTableView: tableView)
    end
  end

  def submit
    if @challenged_row.score == 0 && @challenger_row.score == 0
      App.alert("Please enter a score")
      return false
    end

    navigationItem.rightBarButtonItem.enabled = false
    @spinner = Spin.new(self.view)
    Latter::API.new.post(
      "/games/#{@game.id}/score",
      game: {
        challenger_score: @challenger_row.score,
        challenged_score: @challenged_row.score
      }
    ) do |response|
      @spinner.stop
      navigationItem.rightBarButtonItem.enabled = true
      if response.ok?
        navigationController.topViewController.viewDidLoad
        navigationController.popToRootViewControllerAnimated(true)
      else
        App.alert("There was a problem recording your score. Please try again.")
      end
    end
  end


end