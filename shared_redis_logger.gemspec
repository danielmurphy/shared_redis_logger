# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shared_redis_logger/version'

Gem::Specification.new do |gem|
  gem.name          = "shared_redis_logger"
  gem.version       = SharedRedisLogger::VERSION
  gem.authors       = ["Zack Hubert"]
  gem.email         = ["zhubert@gmail.com"]
  gem.description   = %q{Send Rails 3 logs to Redis (across multiple apps) for common development aggregation.}
  gem.summary       = %q{Send Rails 3 logs to Redis (across multiple apps) for common development aggregation.}
  gem.homepage      = ""
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'redis', '~> 3'
end