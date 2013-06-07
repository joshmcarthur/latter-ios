class ScoreController < UITableViewController

  def initWithGame(game)
    @game = game
    self.initWithStyle(UITableViewStyleGrouped)
  end

  def viewWillAppear(animated)
   navigationItem.title = 'Enter Score'
   navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
  end

  def submit

  end


end