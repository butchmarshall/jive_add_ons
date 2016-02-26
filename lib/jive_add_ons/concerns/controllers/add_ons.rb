module JiveAddOns
	module Concerns
		module Controllers
			module AddOns
				extend ActiveSupport::Concern

				def create
					@add_on = Jive::AddOn.new(register_params)
					@add_on.name = params[:name]
					@add_on.uninstalled = false

					render :nothing => true, :status => ((@add_on.save)? 204 : 403)
				end

				def destroy
					status = 403

					@add_on = Jive::AddOn.where(unregister_params).first
					if @add_on && @add_on.update_attributes(:uninstalled => true)
						status = 204
					end

					render :nothing => true, :status => status
				end

				protected
					def validate_add_on_name
						# Add on name is whitelisted
						if JiveAddOns.config.respond_to?(:whitelist) && JiveAddOns.config.whitelist.length > 0 && !JiveAddOns.config.whitelist.include?(params[:name])
							raise ActionController::UnknownController
						end
						# Add on name is blacklisted
						if JiveAddOns.config.respond_to?(:blacklist) && JiveAddOns.config.blacklist.length > 0 && JiveAddOns.config.blacklist.include?(params[:name])
							raise ActionController::UnknownController
						end
					end

					def failure_404
						render :nothing => true, :status => 404
					end

				private
					def json_params
						ActionController::Parameters.new(JSON.parse(request.body.read))
					end

					def unregister_params
						json_params.tap { |whitelisted|
							whitelisted[:tenant_id] = whitelisted[:tenantId]
							whitelisted[:client_id] = whitelisted[:clientId]
							whitelisted[:jive_url] = whitelisted[:jiveUrl]
							whitelisted[:jive_signature_url] = whitelisted[:jiveSignatureURL]
						}.permit(
							:tenant_id,
							:client_id,
							:jive_url,
							:jive_signature_url
						)
					end

					def register_params
						json_params.tap { |whitelisted|
							whitelisted[:tenant_id] = whitelisted[:tenantId]
							whitelisted[:client_id] = whitelisted[:clientId]
							whitelisted[:client_secret] = whitelisted[:clientSecret]
							whitelisted[:jive_url] = whitelisted[:jiveUrl]
							whitelisted[:jive_signature] = whitelisted[:jiveSignature]
							whitelisted[:jive_signature_url] = whitelisted[:jiveSignatureURL]
							whitelisted[:timestamp] = whitelisted[:timestamp]
						}.permit(
							:tenant_id,
							:client_id,
							:client_secret,
							:jive_url,
							:jive_signature,
							:jive_signature_url,
							:timestamp
						)
					end
			end
		end
	end
end