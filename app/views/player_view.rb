class PlayerView < UIView

  def initWithPlayerAndFrame(player, frame)
    @player = player
    self.initWithFrame(frame)
  end

  def initWithFrame(frame)
    super

    self.backgroundColor = UIColor.whiteColor
    addPlayerImage
    addPlayerRating
    addPlayerGameCount
    addChallengeButton
  end

  private

  def addChallengeButton
    @challengeButton = NiceButton.initWithTextAndFrame(
      "Challenge #{@player.name}",
      [[10, 110], [self.frame.size.width - 20, 45]]
    )
    @challengeButton.addTarget(self, action: :challengeButtonClicked,  forControlEvents: UIControlEventTouchUpInside)
    self.addSubview(@challengeButton)
  end

  def challengeButtonClicked
    UIActionSheet.alloc.init.tap do |as|
      as.title = "Are you sure you want to challenge?"
      as.delegate = self
      as.addButtonWithTitle("Challenge!")
      as.destructiveButtonIndex = 0
      as.addButtonWithTitle("Cancel")
      as.cancelButtonIndex = 1
      as.showFromRect(@challengeButton.frame, inView:self, animated:true)
    end
  end

  def addPlayerImage
    self.addSubview(
      PlayerGravatar.alloc.initWithImageAndFrame(
        @player.load_gravatar_image,
        [[10, 10], [90, 90]]
      )
    )
  end

  def addPlayerRating
    player_rating_icon = UILabel.alloc.initWithFrame([[110, 12], [30, 45]])
    player_rating_icon.text = FontAwesome.icon("bar-chart")
    player_rating_icon.font = FontAwesome.fontWithSize(20.0)
    player_rating_icon.backgroundColor = UIColor.clearColor

    player_rating = UILabel.alloc.initWithFrame([[140, 10], [self.frame.size.width - 140, 45]])
    player_rating.font = UIFont.systemFontOfSize(20.0)
    player_rating.backgroundColor = UIColor.clearColor
    player_rating.opaque = true
    player_rating.text = "#{@player.rating} Points"

    self.addSubview(player_rating_icon)
    self.addSubview(player_rating)
  end

  def addPlayerGameCount
    player_game_count_icon = UILabel.alloc.initWithFrame([[110, 57], [30, 45]])
    player_game_count_icon.text = FontAwesome.icon("reorder")
    player_game_count_icon.font = FontAwesome.fontWithSize(20.0)
    player_game_count_icon.backgroundColor = UIColor.clearColor

    player_game_count = UILabel.alloc.initWithFrame([[140, 55], [self.frame.size.width - 140, 45]])
    player_game_count.font = UIFont.systemFontOfSize(20.0)
    player_game_count.backgroundColor = UIColor.clearColor
    player_game_count.text = "#{@player.game_count} Games"

    self.addSubview(player_game_count_icon)
    self.addSubview(player_game_count)
  end
end