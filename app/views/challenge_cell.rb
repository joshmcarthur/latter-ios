class ChallengeCell < UITableViewCell
  CellID = 'ChallengeCell'

  def self.cellForChallenge(challenge, involvesCurrentPlayer:ours, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(ChallengeCell::CellID) || ChallengeCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:CellID)
    cell.indentationWidth = 0
    cell.fillWithChallenge(challenge, inTableView:tableView)
    cell
  end

  def fillWithChallenge(challenge, inTableView: tableView)
    @challenger_image = PlayerGravatar.alloc.initWithImageAndFrame(
      challenge.challenger.load_gravatar_image,
      [[5, 5], [64, 64]]
    ) if challenge.challenger



    @challenged_image = PlayerGravatar.alloc.initWithImageAndFrame(
      challenge.challenged.load_gravatar_image,
      [[5, 5], [64, 64]]
    ) if challenge.challenged

    self.contentView.addSubview(@challenger_image)
    self.contentView.addSubview(@challenged_image)
  end

  def layoutSubviews
    super
    cell_bounds = self.contentView.frame.size
    @challenged_image.frame = CGRectMake(cell_bounds.width - (64 + 5), 5, 64, 64)
  end
end