# frozen_string_literal: true

::Dry::Rails.container do
  register('http_repository') { ::HttpRepository.new(logger: Rails.logger) }
end
