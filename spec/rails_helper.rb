# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
require 'webmock/rspec'
WebMock.disable_net_connect!

# Prevent running if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Dir[Rails.root.join('spec', 'support', '*.rb').to_path].each(&method(:require))
Dir[Rails.root.join('spec', 'support', 'shared_examples', '*.rb').to_path].each(&method(:require))
