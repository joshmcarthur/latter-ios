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
    App.alert("Submitted: #{@challenger_row.score}, #{@challenged_row.score}")
  end


end