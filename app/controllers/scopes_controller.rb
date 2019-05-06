class ScopesController < ApplicationController
  def index
    scopes = ScopeResource.all(params)
    respond_with(scopes)
  end

  def show
    scope = ScopeResource.find(params)
    respond_with(scope)
  end

  def create
    scope = ScopeResource.build(params)

    if scope.save
      render jsonapi: scope, status: 201
    else
      render jsonapi_errors: scope
    end
  end

  def update
    scope = ScopeResource.find(params)

    if scope.update_attributes
      render jsonapi: scope
    else
      render jsonapi_errors: scope
    end
  end

  def destroy
    scope = ScopeResource.find(params)

    if scope.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: scope
    end
  end
end
