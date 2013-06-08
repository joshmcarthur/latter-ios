class AuthKeyController < Formotion::FormController

  def initWithForm(form, callbackTo: callbackTo)
    @callback = callbackTo
    self.initWithForm(form)

    self
  end

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

    if data["auth_token"].strip == ""
      show_error("Auth token must not be blank!")
      return false
    else
      Latter::API.validate_token!(data["auth_token"]) do |result, token, player_id|
        if result
          App::Persistence['auth_token'] = token
          App::Persistence['current_player_id'] = player_id
          self.presentViewController(@callback, animated: true, completion: nil)
        else
          show_error("Auth key was not valid, please try again.")
        end
      end
    end
  end

  def show_error(message)
    App.alert(message)
  end

  def self.build_form
    Formotion::Form.new({
      sections: [{
        title: nil,
        rows: [{
          title: 'Auth Token',
          key: 'auth_token',
          type: :string,
          auto_correction: :no,
          auto_capitalization: :none,
          value: App::Persistence['auth_token']
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