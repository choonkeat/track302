require_dependency "track302/application_controller"

module Track302
  class RedirectController < ApplicationController
    WHITELIST = Regexp.new(ENV.fetch('TRACK302_CLICK_DATA_MATCH', 'HTTP_USER_AGENT|HTTP_REFERER|REMOTE_ADDR'))

    def show
      filtered_env = request.env.inject({}) {|sum, (k,v)| (WHITELIST.match(k) ? sum.merge(k => v) : sum) }
      if link = Link.find_by(uuid: params[:uuid])
        Click.create(uuid: params[:uuid], data: filtered_env)
        redirect_to link.original
      else
        render nothing: true, status: 404
      end
    end
  end
end
