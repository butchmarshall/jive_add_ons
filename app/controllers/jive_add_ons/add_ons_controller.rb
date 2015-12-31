require_dependency "jive_add_ons/application_controller"

module Concerns
	module Controllers
		module AddOns
			extend JiveAddOns::Concerns::Controllers::AddOns
		end
	end
end

module JiveAddOns
	class AddOnsController < ApplicationController
		include Concerns::Controllers::AddOns
		rescue_from ActionController::BadRequest, :with => :failure_403
		rescue_from ActionController::UnknownController, :with => :failure_404

		before_filter :validate_authenticity
		before_filter :validate_add_on_name
	end
end
