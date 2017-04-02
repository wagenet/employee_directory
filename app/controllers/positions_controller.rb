class PositionsController < ApplicationController
  jsonapi resource: PositionResource

  def index
    render_jsonapi(Position.all)
  end
end
