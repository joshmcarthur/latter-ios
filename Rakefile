# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'formotion'
require 'bubble-wrap/all'
require 'motion-fontawesome'

require 'dotenv'
Dotenv.load

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Latter'
  app.device_family = [:iphone, :ipad]
  app.files += Dir.glob(File.join(app.project_dir, 'app/lib/**/*.rb')) |
              Dir.glob(File.join(app.project_dir, 'app/**/*.rb'))
  app.icons = ["icon_iphone.png", "icon_ipad.png", "icon_iphone@2x.png", "icon_ipad@2x.png"]
  app.provisioning_profile = ENV['RUBYMOTION_PROVISIONING_PROFILE']
  app.codesign_certificate = ENV['RUBYMOTION_CODESIGN_CERTIFICATE']
end
