module JiveAddOns
	module Concerns
		module Controllers
			module AddOns
				extend ActiveSupport::Concern

				def create
					@add_on = JiveAddOns::AddOn.new(register_params)
					@add_on.name = params[:name]
					@add_on.uninstalled = false
					@add_on.save

					render :nothing => true, :status => 204
				end

				def destroy
					@add_on = JiveAddOns::AddOn.where(unregister_params).first
					@add_on.update_attributes(:uninstalled => true)

					render :nothing => true, :status => 204
				end

				protected
					def validate_add_on_name
						# Add on name is whitelisted
						if JiveAddOns.config.whitelist.length > 0 && !JiveAddOns.config.whitelist.include?(params[:name])
							raise ActionController::UnknownController
						end
						# Add on name is blacklisted
						if JiveAddOns.config.blacklist.length > 0 && JiveAddOns.config.blacklist.include?(params[:name])
							raise ActionController::UnknownController
						end
					end

					def validate_authenticity
						if !::Jive::SignedRequest.validate_registration(json_params)
							raise ActionController::BadRequest
						end
					end

					def failure_404
						render :nothing => true, :status => 404
					end

					def failure_403
						render :nothing => true, :status => 403
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
						}.permit(
							:tenant_id,
							:client_id,
							:client_secret,
							:jive_url,
							:jive_signature,
							:jive_signature_url
						)
					end
			end
		end
	end
end