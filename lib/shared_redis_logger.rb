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
      %w{debug info warn error fatal}.each do |level|
        @redis.sadd "shared_logger:#{@app_name}:sets", level
      end
    end

    # metaprograms all the .debug() etc methods
    %w{debug info warn error fatal}.each do |logger_method|
      define_method logger_method.to_sym do |*args,&block|
        message = args.first || block && block.call
        log_entry(message,logger_method)
      end
    end

    def entries(level, start=0, per_page=50)
      entry_list = @redis.sort("shared_logger:#{@app_name}:set:#{level}", { :limit => [ start, per_page ], :order => "DESC" })
      fetch_entries(entry_list)
    end

    def fetch_entries(entry_list)
      futures = []
      @redis.multi do
        entry_list.each do |e|
          futures << @redis.hgetall("shared_log:#{@app_name}:#{e}")
        end
      end
      entries = []
      futures.each do |f|
        entries << f.value
      end
      return entries
    end

    # when logging, we make a stored copy (for later digging) and
    # publish out to any listening clients
    def log_entry(message, level)
      tstamp = Time.now.to_i
      uniq_id = "#{tstamp}#{rand(1000)}"
      log_entry = {:message => message, :timestamp => tstamp}
      log_entry.each { |key, value| @redis.hset "shared_log:#{@app_name}:#{uniq_id}", key, value }
      @redis.sadd "shared_logger:#{@app_name}:set:#{level}", uniq_id
      @redis.publish "shared_logger", log_entry.merge(:level => level, :app => @app_name).to_json
      return true
    end
  end
end