class ChallengesController < UITableViewController

  YOUR_CHALLENGES_SECTION = 0
  ALL_CHALLENGES_SECTION  = 1

  def initWithStyle(style)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Challenges", image: UIImage.imageNamed("challenges.png"), tag: 3)
    self
  end


  def tableView(tableView, titleForHeaderInSection: section)
    if section == YOUR_CHALLENGES_SECTION
      "Your Challenges"
    elsif section == ALL_CHALLENGES_SECTION
      "Latest Challenges"
    end
  end

  def viewDidLoad
    @challenges = []
    view.dataSource = view.delegate = self

    Latter::API.new.get("/games", {complete: "false", per_page: "25"}) do |response|
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_s)
        @challenges = json.select { |hash| hash["challenger"] && hash["challenged"] }.map { |game_hash| Game.new(game_hash) }
        view.reloadData
      else
        $stderr.puts response.status_code
        App.alert(response.error_message)
      end
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    return case indexPath.section
           when ALL_CHALLENGES_SECTION
            ChallengeCell.cellForChallenge(@challenges[indexPath.row], involvesCurrentPlayer: false, inTableView:tableView)
           end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    return case indexPath.section
           when ALL_CHALLENGES_SECTION
            ChallengeCell.cellForChallenge(@challenges[indexPath.row], involvesCurrentPlayer: false, inTableView:tableView)
           end
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    # Arbitrary
    64 + 10
  end

  def tableView(tableView, numberOfRowsInSection: section)
    if section == ALL_CHALLENGES_SECTION
      @challenges.count
    else
      0
    end
  end

  def numberOfSectionsInTableView(tableView)
    2
  end
end