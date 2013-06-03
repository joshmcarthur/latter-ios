class PlayerGravatar < UIImageView

  def initWithImageAndFrame(image, frame)
    init_image = initWithFrame(frame)
    init_image.image = image
    init_image.layer.cornerRadius = 5.0;
    init_image.layer.masksToBounds = true;

    init_image
  end
end
