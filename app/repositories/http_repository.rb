# frozen_string_literal: true

class HttpRepository
  include ::Dry::Monads[:result]
  include ::ProjectCookbook::Import[
    :logger,
  ]

  def get(url, **options, &block)
    response = ::HTTParty.get(url, default_request_options.deep_merge(options), &block)
    build_result(response)
  end

  private

  def default_request_options
    @default_request_options ||= {
      logger:           logger,
      log_level:        :debug,
      log_format:       :curl,
      rails_on:         [],
      follow_redirects: false
    }
  end

  def build_result(response)
    case response.code
    when 200..299 then Success(response)
    when 400..499 then Failure(:http_request_error)
    when 500..599 then Failure(:http_application_error)
    else               Failure(:http_unknown_response_error)
    end
  end
end
