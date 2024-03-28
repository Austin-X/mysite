# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_csrf_cookie

  def set_csrf_cookie
    $hst = request.host
    $dom = request.domain
    cookies['XSRF-TOKEN'] =
      { value: form_authenticity_token, secure: Rails.env.development?, domain: %w[lawl testing] }
  end
end
