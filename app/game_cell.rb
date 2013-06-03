class GameCell < UITableViewCell
  CellID = 'GameCell'

  def self.cellForGame(game, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(GameCell::CellID) || GameCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:CellID)
    cell.fillWithGame(game, inTableView:tableView)
    cell
  end

  def fillWithGame(game, inTableView: tableView)

    challenger_image = UIImageView.alloc.initWithFrame([[0, 0], [45, 45]])
    challenged_image = UIImageView.alloc.initWithFrame([[self.frame.size.width - 45, 0], [45, 45]])

    challenger_image.image = game.challenger.load_gravatar_image if game.challenger
    challenged_image.image = game.challenged.load_gravatar_image if game.challenged

    score_label = UILabel.alloc.initWithFrame([[45, 0], [self.frame.size.width - 90, 45]])
    score_label.text = game.score_string

    [challenger_image, challenged_image, score_label].each { |element| self.contentView.addSubview(element) }
  end


end
