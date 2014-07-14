class TenantsController < ApplicationController
  def index
    @tenants = Tenant.paginate(page: params[:page], :per_page => 10)
  end		

  def show
    @tenant = Tenant.find(params[:id])	
  end

  def new
  	@tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    
    if @tenant.save     
      flash[:success] = "The new tenant has been created."
      
      redirect_to @tenant
    else
      render 'new'
    end
  end

  def edit
		@tenant = Tenant.find(params[:id])	
  end  

  def update
		@tenant = Tenant.find(params[:id])	

    if @tenant.update_attributes(tenant_params)
      flash[:success] = "Profile updated"
      redirect_to @tenant
    else
      render 'edit'
    end
  end   

  def destroy
    
    @tenant = Tenant.find(params[:id])    
    @tenant.destroy
    
    respond_to do |format|      
      format.js
    end    
  end   

  private

    def tenant_params
      params.require(:tenant).permit(:name, :subdomain)
    end
 
end
