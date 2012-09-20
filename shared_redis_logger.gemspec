# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "shared_redis_logger"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zack Hubert"]
  s.date = "2012-09-20"
  s.description = "Send Rails 3 logs to Redis (across multiple apps) for common development aggregation."
  s.email = "zhubert@gmail.com"
  s.extra_rdoc_files = ["README.rdoc", "lib/shared_redis_logger.rb"]
  s.files = ["README.rdoc", "Rakefile", "lib/shared_redis_logger.rb", "shared_redis_logger.gemspec"]
  s.homepage = "http://github.com/zhubert/shared_redis_logger"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Shared_redis_logger", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "shared_redis_logger"
  s.rubygems_version = "1.8.24"
  s.summary = "Send Rails 3 logs to Redis (across multiple apps) for common development aggregation."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
