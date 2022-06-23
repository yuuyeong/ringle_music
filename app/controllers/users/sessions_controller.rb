# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  wrap_parameters :user, format: [:url_encoded_form, :multipart_form, :json]
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: resource.as_json(except: [:jti]), status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "로그아웃 성공" }, status: :ok
  end

  def log_out_failure
    render json: { message: "로그아웃 실패" }, status: :unauthorized
  end
end
