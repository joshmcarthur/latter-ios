# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'formotion'
require 'bubble-wrap/all'
require 'motion-fontawesome'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Latter'
  app.files += Dir.glob(File.join(app.project_dir, 'app/lib/**/*.rb')) |
              Dir.glob(File.join(app.project_dir, 'app/**/*.rb'))
  app.icons = ["icon_iphone.png", "icon_ipad.png", "icon_iphone@2x.png", "icon_ipad@2x.png"]
end
