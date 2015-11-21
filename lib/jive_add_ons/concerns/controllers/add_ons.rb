module JiveAddOns
	module Concerns
		module Controllers
			module AddOns
				extend ActiveSupport::Concern

				def create
					@add_on = JiveAddOns::AddOn.new(register_params)
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
					def validate_authenticity
						if !::Jive::SignedRequest.validate_registration(json_params)
							raise ActionController::BadRequest
						end
					end

					def failure
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