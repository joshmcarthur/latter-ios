class Spin
  def initialize(view)
    @spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    @spinner.center = view.center
    @spinner.hidesWhenStopped = true
    @spinner.startAnimating
    view.addSubview(@spinner)

    self
  end

  def stop
    @spinner.stopAnimating
  end
end
