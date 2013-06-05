class ChallengesController < UITableViewController
  def initWithStyle(style)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Challenges", image: UIImage.imageNamed("challenges.png"), tag: 3)
    self
  end
end