class ChallengesController < UITableViewController

  YOUR_CHALLENGES_SECTION = 0
  ALL_CHALLENGES_SECTION  = 1

  def initWithStyle(style)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Challenges", image: UIImage.imageNamed("challenges.png"), tag: 3)
    self
  end


  def viewWillAppear(animated)
   navigationItem.title = 'Challenges'
   @refresh_button = RefreshButton.new(self, "viewDidLoad")
  end

  def viewDidAppear(animated)
    super
    tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow, animated: true)
  end


  def tableView(tableView, titleForHeaderInSection: section)
    if section == YOUR_CHALLENGES_SECTION
      "Your Challenges"
    # elsif section == ALL_CHALLENGES_SECTION
    #   "Latest Challenges"
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    game = @your_challenges[indexPath.row]
    navigationController.pushViewController(ScoreController.alloc.initWithGame(game), animated: true)

  end

  def viewDidLoad
    @spinner = Spin.new(self.view)
    @challenges = []
    @your_challenges = []

    view.dataSource = view.delegate = self

    Latter::API.new.get("/games.json", {complete: "false"}) do |response|
      @spinner.stop
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_s)
        @challenges = json.select { |hash| hash["challenger"] && hash["challenged"] }.map { |game_hash| Game.new(game_hash) }
        @your_challenges = @challenges.select do |c|
          c.challenged.id == App::Persistence['current_player_id'] || \
          c.challenger.id == App::Persistence['current_player_id']
        end

        if @your_challenges.length > 0 && @no_data_label
          @no_data_label.removeFromSuperview
        elsif @your_challenges.length < 1 && @no_data_label.nil?
          add_no_data_label
        end

        view.reloadData
      else
        App.alert(response.error_message)
      end
    end
  end

  def add_no_data_label
    @no_data_label = UILabel.alloc.initWithFrame([[20, 50], [self.view.frame.size.width - 40, 20]]).tap do |label|
      label.text = "No challenges at the moment"
      label.autoresizingMask = UIViewAutoresizingFlexibleWidth
      label.textAlignment = NSTextAlignmentCenter
      label.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize)
      label.backgroundColor = UIColor.clearColor
    end

    self.view.addSubview(@no_data_label)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    return case indexPath.section
           when YOUR_CHALLENGES_SECTION
            ChallengeCell.cellForChallenge(@your_challenges[indexPath.row], involvesCurrentPlayer: true, inTableView: tableView)
           end
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    # Arbitrary
    64 + 10
  end

  def tableView(tableView, numberOfRowsInSection: section)
    # if section == ALL_CHALLENGES_SECTION
    #   @challenges.count
    if section == YOUR_CHALLENGES_SECTION
      @your_challenges.count
    else
      0
    end
  end


  def numberOfSectionsInTableView(tableView)
    1
  end
end