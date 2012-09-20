require "shared_redis_logger/version"
require 'redis'

# with inspiration from:
# http://github.com/masonoise/redis_logger
# https://github.com/crohr/syslogger

module SharedRedisLogger

  # automatically makes this the default logger
  class Railtie < ::Rails::Railtie
    initializer 'logging.initialize', :before => 'initialize_logger' do
      ::Rails.logger = ::SharedRedisLogger::Logger.new
    end
  end

  class Logger
    attr_accessor :level

    def initialize
      @app_name = Rails.application.class.parent_name.downcase
      @redis = Redis.new
    end

    # metaprograms all the .debug() etc methods
    %w{debug info warn error fatal}.each do |logger_method|
      define_method logger_method.to_sym do |*args,&block|
        message = args.first || block && block.call
        log_entry(message,logger_method)
      end
    end

    # when logging, we make a stored copy (with expiry) and
    # publish out to any listening clients
    def log_entry(message, level)
      tstamp = Time.now.to_i
      log_entry = {:message => message, :timestamp => tstamp, :level => level, :app => @app_name}
      @redis.zadd "shared_logger", tstamp, log_entry
      @redis.publish "shared_logger", log_entry.to_json
      return true
    end
  end
end