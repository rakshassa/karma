class DashboardsController < ApplicationController
  def show
  	puts request.subdomain
    @tenant = Tenant.find_by_subdomain!(request.subdomain)	
  end	
end
