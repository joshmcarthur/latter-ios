class GameCell < UITableViewCell
  CellID = 'GameCell'

  def self.cellForGame(game, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(GameCell::CellID) || GameCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:CellID)
    cell.fillWithGame(game, inTableView:tableView)
    cell
  end

  def fillWithGame(game, inTableView: tableView)
    challenger_image = PlayerGravatar.alloc.initWithImageAndFrame(
      game.challenger.load_gravatar_image,
      [[5, 5], [45, 45]]
    ) if game.challenger

    challenged_image = PlayerGravatar.alloc.initWithImageAndFrame(
      game.challenged.load_gravatar_image,
      [[self.frame.size.width - 50, 5], [45, 45]]
    ) if game.challenged

    score_label = UILabel.alloc.initWithFrame([[50, 5], [self.frame.size.width - 110, 45]])
    score_label.textAlignment = NSTextAlignmentCenter
    score_label.text = game.score_string

    [challenger_image, challenged_image, score_label].each do |element|
      self.contentView.addSubview(element)
    end
  end


end
