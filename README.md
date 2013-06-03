Latter for iOS
===

Latter for iOS is a [RubyMotion](http://rubymotion.com) application for interfacing with [Latter](https://latter.herokuapp.com).


Installing
---

You can't install this right now via the app store, as I need to jump through Apple hoops. 

If you've got RubyMotion, you can try this out on your device by following the instructions below and running `rake device` instead of just `rake` to install.

If you're intested in progress, I intermittently update screenshots of what I've got working in [the 'screenshots/' folder](https://github.com/joshmcarthur/latter-ios/tree/master/screenshots).

Building
---

To build the application, simply clone it, and then run the Rake task to build and run the app in the iOS simulator:

* git clone git@github.com:joshmcarthur/latter-ios.git
* cd latter-ios
* bundle install
* rake

Testing
---

Right now, there's only the default tests, but you can run `rake spec` to run them anyway.

Roadmap
---

1. Challenge other players
2. Complete games
3. View 'profile' of player
4. View your profile
5. View trends in list

License
---

Given on how much I've depended on other source code being available under open licenses, I couldn't possibly license this under anything other than the [MIT License](http://opensource.org/licenses/MIT)


