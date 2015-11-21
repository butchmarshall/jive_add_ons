module JiveAddOns
	module Concerns
		module Controllers
			module AddOns
				extend ActiveSupport::Concern

				def create
					@add_on = JiveAddOns::AddOn.create(register_params)
					render :text => @add_on.inspect
				end

				def destroy
					@add_on = JiveAddOns::AddOn.where(unregister_params).first

					respond_to do |format|
						if @add_on && @add_on.update_attributes(:uninstalled => true)
							format.json { render :json => {} }
						else
							format.json { render :json => {}, status: :not_found }
						end
					end
				end

				protected
					def validate_authenticity
						if !::Jive::SignedRequest.validate_registration(json_params)
							raise 'Could not validate request'
						end
					end

				private
					def json_params
						ActionController::Parameters.new(JSON.parse(request.body.read))
					end

					def unregister_params
						params.tap { |whitelisted|
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