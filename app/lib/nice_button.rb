class NiceButton < UIButton
  def self.initWithTextAndFrame(text, frame, color = "grey", capSize = 18)
    background_image = UIImage.imageNamed("#{color}Button.png")
                              .resizableImageWithCapInsets(
                                UIEdgeInsetsMake(capSize, capSize, capSize, capSize)
                              )

    highlight_image = UIImage.imageNamed("#{color}ButtonHighlight.png")
                              .resizableImageWithCapInsets(
                                UIEdgeInsetsMake(capSize, capSize, capSize, capSize)
                              )

    UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |btn|
      btn.setTitle("Challenge", forState: UIControlStateNormal)
      btn.frame = frame
      btn.setBackgroundImage(background_image, forState: UIControlStateNormal)
      btn.setBackgroundImage(highlight_image, forState: UIControlStateHighlighted)
    end
  end
end