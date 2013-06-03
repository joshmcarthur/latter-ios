class PlayerController < UIViewController

  def initWithPlayer(player)
    @player = player
    self.initWithNibName(nil, bundle: nil)
  end

  def viewDidLoad
    super

    @player_container = UIView.alloc.initWithFrame([[0, 0], [self.view.frame.size.width, 110]])
    @player_container.backgroundColor = UIColor.whiteColor
    self.view.addSubview(@player_container)

    addPlayerImage
    addPlayerRating
    addPlayerGameCount
    addPlayerGameTable
  end

  def viewWillAppear(animated)
    navigationItem.title = @player.name
  end


  private

  def addPlayerImage
    @player_image = UIImageView.alloc.initWithFrame([[10, 10], [90, 90]])
    @player_image.image = @player.load_gravatar_image
    @player_image.layer.cornerRadius = 5.0;
    @player_image.layer.masksToBounds = true;

    @player_container.addSubview(@player_image)
  end

  def addPlayerRating
    @player_rating_icon = UILabel.alloc.initWithFrame([[110, 12], [30, 45]])
    @player_rating_icon.text = FontAwesome.icon("bar-chart")
    @player_rating_icon.font = FontAwesome.fontWithSize(20.0)
    @player_rating_icon.backgroundColor = UIColor.clearColor

    @player_rating = UILabel.alloc.initWithFrame([[140, 10], [self.view.frame.size.width - 140, 45]])
    @player_rating.font = UIFont.systemFontOfSize(20.0)
    @player_rating.backgroundColor = UIColor.clearColor
    @player_rating.opaque = true
    @player_rating.text = "#{@player.rating} Points"

    @player_container.addSubview(@player_rating_icon)
    @player_container.addSubview(@player_rating)
  end

  def addPlayerGameCount
    @player_game_count_icon = UILabel.alloc.initWithFrame([[110, 57], [30, 45]])
    @player_game_count_icon.text = FontAwesome.icon("reorder")
    @player_game_count_icon.font = FontAwesome.fontWithSize(20.0)
    @player_game_count_icon.backgroundColor = UIColor.clearColor

    @player_game_count = UILabel.alloc.initWithFrame([[140, 55], [self.view.frame.size.width - 140, 45]])
    @player_game_count.font = UIFont.systemFontOfSize(20.0)
    @player_game_count.backgroundColor = UIColor.clearColor
    @player_game_count.opaque = true
    @player_game_count.text = "600 Games"

    @player_container.addSubview(@player_game_count_icon)
    @player_container.addSubview(@player_game_count)
  end

  def addPlayerGameTable
    table_frame = [
                    [0, @player_container.frame.size.height],
                    [
                      self.view.bounds.size.width,
                      self.view.bounds.size.height - @player_container.frame.size.height
                    ]
                  ]
    @player_game_table = GameTableView.alloc.initWithPlayerAndFrame(@player, table_frame, style: UITableViewStylePlain)
    @player_game_table.load!
    @player_container.addSubview(@player_game_table)
  end
end