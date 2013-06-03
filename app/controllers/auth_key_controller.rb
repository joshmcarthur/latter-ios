class AuthKeyController < Formotion::FormController

  def viewDidLoad
    super
    self.navigationItem.title = "Access Credentials"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
  end

  def submit
    data = self.form.render

    # regexp from http://stackoverflow.com/questions/4716513/ruby-regular-expression-to-match-a-url
    if !(data["api_endpoint"] =~ /https?:\/\/[\S]+/)
      show_error("API Endpoint must be a URL")
      return false
    else
      App::Persistence['api_endpoint'] = data['api_endpoint']
    end

    if data["auth_key"].strip == ""
      show_error("Auth key must not be blank!")
      return false
    else
      Latter::API.validate_token!(data["auth_key"]) do |result, token|
        if result
          App::Persistence['auth_token'] = token
          navigationController.pushViewController(PlayersController.alloc.initWithStyle(UITableViewStylePlain), animated: true)
        else
          show_error("Auth key was not valid, please try again.")
        end
      end
    end
  end

  def show_error(message)
    alert = UIAlertView.alloc.init
    alert.message = message
    alert.addButtonWithTitle("OK")
    alert.show
  end

  def self.build_form
    Formotion::Form.new({
      sections: [{
        title: nil,
        rows: [{
          title: 'Auth Key',
          key: 'auth_key',
          type: :string,
          auto_correction: :no,
          auto_capitalization: :none
        },  {
          title: 'Latter URL',
          key: 'api_endpoint',
          type: :string,
          auto_correction: :no,
          auto_capitalization: :none,
          value: App::Persistence['api_endpoint']
        }]
      }]
    })
  end
end