class Tenant < ActiveRecord::Base
	scope :find_by_subdomain, ->(subdomain_param) { where("lower(subdomain) = ?", subdomain_param.downcase).first }

	before_save { |tenant| tenant.subdomain = subdomain.downcase }
end
