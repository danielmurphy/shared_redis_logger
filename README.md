SharedRedisLogger
==================

Send Rails 3 logs to Redis (across multiple apps) for common development aggregation.

Use something like [log_window](http://github.com/zhubert/log_window) to watch the logs in realtime in the browser.

Helpful if you use [Pow](http://pow.cx/) and don't want to open term windows all the time.

Installation
---------------

Add this line to your application's Gemfile:

    gem 'shared_redis_logger', :git => 'git://github.com/zhubert/shared_redis_logger', :group => :development

And then execute:

    $ bundle

Usage
-----------

Not ready for primetime yet.  Conceptual sketch.

Contributing
--------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request