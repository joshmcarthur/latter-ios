class PlayerCell < UITableViewCell
  CellID = 'PlayerCell'
  MessageFontSize = 14

  def self.cellForPlayer(player, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(PlayerCell::CellID) || PlayerCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:CellID)
    cell.fillWithPlayer(player, inTableView:tableView)
    cell
  end

  def initWithStyle(style, reuseIdentifier:cellid)
    if super
      self.textLabel.numberOfLines = 0
      self.textLabel.font = UIFont.systemFontOfSize(MessageFontSize)
    end
    self
  end

  def fillWithPlayer(player, inTableView:tableView)
    self.textLabel.text = player.name
    self.detailTextLabel.text = player.rating.to_s
    self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton

    unless player.gravatar_image
      self.imageView.image = nil
      Dispatch::Queue.concurrent.async do
        gravatar_image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(player.gravatar_url))
        if gravatar_image_data
          player.gravatar_image = UIImage.alloc.initWithData(gravatar_image_data)
          Dispatch::Queue.main.sync do
            self.contentView.addSubview(PlayerGravatar.alloc.initWithImageAndFrame(
              player.gravatar_image,
              [[5, 5], [49, 49]]
            ))
            tableView.delegate.reloadRowForPlayer(player)
          end
        end
      end
    else
      self.contentView.addSubview(PlayerGravatar.alloc.initWithImageAndFrame(
        player.gravatar_image,
        [[5, 5], [49, 49]]
      ))
    end
  end

  def self.heightForPlayer(player, width)
    constrain = CGSize.new(width - 57, 1000)
    size = player.name.sizeWithFont(UIFont.systemFontOfSize(MessageFontSize), constrainedToSize:constrain)
    [57, size.height + 8].max
  end

  def layoutSubviews
    super
    label_size = self.frame.size
    self.textLabel.frame = CGRectMake(57, 0, label_size.width - 59, label_size.height)
  end
end
