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
		rescue_from ActionController::BadRequest, :with => :failure

		before_filter :validate_authenticity
	end
end
