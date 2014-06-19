class DashboardsController < ApplicationController
  def show
    @tenant = Tenant.find_by_subdomain!(request.subdomain)	
  end	
end
