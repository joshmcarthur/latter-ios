class Spin
  def initialize(klass, &block)
    spinner = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    spinner.center = klass.view.center
    spinner.hidesWhenStopped = true
    klass.view.addSubview(spinner)

    spinner.startAnimating

    block.call

    spinner.stopAnimating
  end
end
