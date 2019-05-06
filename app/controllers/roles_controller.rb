class RolesController < ApplicationController
  def index
    roles = RoleResource.all(params)
    respond_with(roles)
  end

  def show
    role = RoleResource.find(params)
    respond_with(role)
  end

  def create
    role = RoleResource.build(params)

    if role.save
      render jsonapi: role, status: 201
    else
      render jsonapi_errors: role
    end
  end

  def update
    role = RoleResource.find(params)

    if role.update_attributes
      render jsonapi: role
    else
      render jsonapi_errors: role
    end
  end

  def destroy
    role = RoleResource.find(params)

    if role.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: role
    end
  end
end
