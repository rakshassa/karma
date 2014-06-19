class Tenant < ActiveRecord::Base
	scope :find_by_subdomain, ->(subdomain_param) { where(:subdomain => subdomain_param) }
end
