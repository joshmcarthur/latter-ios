class ScoreEntryCell < UITableViewCell
  attr_reader :score_entry_text_field

  CellID = "ScoreEntryCell"
  MAX_SCORE_LENGTH = 3

  def self.cellForPlayer(player, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(ScoreEntryCell::CellID) || ScoreEntryCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CellID)
    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell.fillWithPlayer(player, inTableView:tableView)
    cell
  end

  def score
    @score_entry_text_field.text.to_i
  end

  def fillWithPlayer(player, inTableView: tableView)
    @player_image = PlayerGravatar.alloc.initWithImageAndFrame(
      player.load_gravatar_image,
      [[5, 5], [64, 64]]
    )

    @score_entry_text_field = UITextField.alloc.initWithFrame([[64 + 10, 5], [100, 50]]).tap do |score_entry_field|
      score_entry_field.setKeyboardType(UIKeyboardTypeNumberPad)
      score_entry_field.font = UIFont.systemFontOfSize(36)
      score_entry_field.adjustsFontSizeToFitWidth = true
      score_entry_field.textAlignment = NSTextAlignmentCenter
      score_entry_field.delegate = self
      score_entry_field.placeholder = "0"
    end

    @player_name_label = UILabel.alloc.initWithFrame([[64 + 10, 50], [100, 14]]).tap do |player_name|
      player_name.text = "#{player.name}'s score"
      player_name.textAlignment = NSTextAlignmentCenter
      player_name.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize)
      player_name.backgroundColor = UIColor.clearColor
    end

    self.contentView.addSubview(@player_image)
    self.contentView.addSubview(@score_entry_text_field)
    self.contentView.addSubview(@player_name_label)
  end

  def textField(textField, shouldChangeCharactersInRange:range, replacementString:string)
    newLength = textField.text.length + string.length - range.length
    newLength > MAX_SCORE_LENGTH ? false : true
  end


  def layoutSubviews
    super
    cell_bounds = self.contentView.frame.size
    @score_entry_text_field.frame = CGRectMake(64 + 10, 5, cell_bounds.width - (64 + 10), 50)
    @player_name_label.frame = CGRectMake(64 + 10, 50, cell_bounds.width - (64 + 10), 14)
  end

end