class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_not_found("Record not found", exception.message)
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render_error("Invalid record", exception.message, :unprocessable_entity)
  end

  rescue_from ActionController::RoutingError do |exception|
    render_not_found("Routing Error", exception.message)
  end

  rescue_from StandardError do |exception|
    render_error("Something went wrong.", exception.message, :unprocessable_entity)
  end

  def render_success(message, response, status = :ok)
    render json: {
      status_code: Rack::Utils::SYMBOL_TO_STATUS_CODE[status],
      message: message,
      data: response[:data],
      errors: nil
    }, status: status
  end

  def render_error(message, errors, status)
    render json: {
      status_code: Rack::Utils::SYMBOL_TO_STATUS_CODE[status],
      message: message,
      data: nil,
      errors: errors
    }, status: status
  end

  def render_not_found(message, errors = nil)
    render json: {
      status_code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found],
      message: message,
      data: nil,
      errors: errors
    }, status: :not_found
  end
end
