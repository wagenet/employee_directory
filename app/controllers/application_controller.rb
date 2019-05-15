class ApplicationController < ActionController::API
  # Previously, we applied these by default
  # Now need to be explicit
  respond_to :json, :jsonapi

  # NO LONGER INCLUDE THESE
  #include Graphiti::Rails
  #include Graphiti::Responders

  # NO LONGER MANUALLY REGISTER
  #register_exception Graphiti::Errors::RecordNotFound,
    #status: 404
end
