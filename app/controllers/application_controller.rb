class ApplicationController < ActionController::Base
    before_action :set_csrf_cookie

    def set_csrf_cookie
        cookies['XSRF-TOKEN'] = { value:  form_authenticity_token, secure: Rails.env.development?, domain: %W(#{request.host}) }
    end
end
