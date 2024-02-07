class ApplicationController < ActionController::Base
  include SetRequestVariant
  include Authenticate
  include SetCurrentRequestDetails
  include Authorize

  include Breadcrumbs
  include Pagy::Backend

  helper_method :turbo_frame_request?
  helper_method :turbo_native_app?
end
