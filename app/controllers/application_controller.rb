# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def current_user
    @current_user ||= User.first
  end

  before_action :set_csrf_cookie

  def set_csrf_cookie
    $hst = request.host
    $dom = request.domain

    cookies['XSRF-TOKEN'] =
      { value: form_authenticity_token, secure: Rails.env.development? }
  end
end
