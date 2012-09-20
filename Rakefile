require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('shared_redis_logger', '0.0.1') do |p|
  p.description     = "Send Rails 3 logs to Redis (across multiple apps) for common development aggregation."
  p.url             = "http://github.com/zhubert/shared_redis_logger"
  p.author          = "Zack Hubert"
  p.email           = "zhubert@gmail.com"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }