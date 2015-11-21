require 'spec_helper'

describe JiveAddOns::AddOnsController, :type => :controller do
	routes { JiveAddOns::Engine.routes }

	before(:each) do
		@header_params = {
			:CONTENT_TYPE => 'application/json',
			:ACCEPT => 'application/json'
		}
	end

	describe 'POST register' do
		describe 'when registering for the first time' do
			it 'should register the addon when passed correct parameters' do
				post :create,
				{
					clientId: '2zm4rzr9aiuvd4zhhg8kyfep229p2gce.i',
					tenantId: 'b22e3911-28ef-480c-ae3b-ca791ba86952',
					jiveSignatureURL: 'https://market.apps.jivesoftware.com/appsmarket/services/rest/jive/instance/validation/8ce5c231-fab8-46b1-b8b2-fc65deccbb5d',
					clientSecret: 'evaqjrbfyu70jlvnap8fhnj2h5mr4vus.s',
					jiveSignature: '0YqbK1nW+L+j3ppE7PHo3CvM/pNyHIDbNwYYvkKJGXU=',
					jiveUrl: 'https://sandbox.jiveon.com',
					timestamp: '2015-11-20T16:04:55.895+0000',
				}.to_json, @header_params

				# Success
				expect(response.code.to_i).to eq(204)
			end

			it 'should fail to register the addon when passed incorrect parameters' do
				post :create,
				{
					clientId: '2zm4rzr9aiuvd4zhhg8kyfep229p2gce.i',
					tenantId: 'b22e3911-28ef-480c-ae3b-ca791ba86952',
					jiveSignatureURL: 'https://market.apps.jivesoftware.com/appsmarket/services/rest/jive/instance/validation/8ce5c231-fab8-46b1-b8b2-fc65deccbb5d',
					clientSecret: 'evaqjrbfyu70jlvnap8fhnj2h5mr4vus.s',
					jiveSignature: '0YqbK1nW+L+j3ppE7PHo3CvM/pNyHIDbNwYYvkKJGXU=',
					jiveUrl: 'https://sandbox-bad.jiveon.com',
					timestamp: '2015-11-20T16:04:55.895+0000',
				}.to_json, @header_params
	
				# Success
				expect(response.code.to_i).to eq(403)
			end
		end

		describe 'when unregistering' do
			before(:each) do
				@add_on = JiveAddOns::AddOn.new({
					"tenant_id"=>"b22e3911-28ef-480c-ae3b-ca791ba86952",
					"client_id"=>"2zm4rzr9aiuvd4zhhg8kyfep229p2gce.i",
					"client_secret"=>"evaqjrbfyu70jlvnap8fhnj2h5mr4vus.s",
					"jive_url"=>"https://sandbox.jiveon.com",
					"jive_signature"=>"0YqbK1nW+L+j3ppE7PHo3CvM/pNyHIDbNwYYvkKJGXU=",
					"jive_signature_url"=>"https://market.apps.jivesoftware.com/appsmarket/services/rest/jive/instance/validation/8ce5c231-fab8-46b1-b8b2-fc65deccbb5d"
				})
				@add_on.save
			end

			it 'should unregister the addon when passed correct parameters' do
				post :destroy,
				{
					clientId: '2zm4rzr9aiuvd4zhhg8kyfep229p2gce.i',
					tenantId: 'b22e3911-28ef-480c-ae3b-ca791ba86952',
					jiveSignatureURL: 'https://market.apps.jivesoftware.com/appsmarket/services/rest/jive/instance/validation/8ce5c231-fab8-46b1-b8b2-fc65deccbb5d',
					clientSecret: 'evaqjrbfyu70jlvnap8fhnj2h5mr4vus.s',
					jiveSignature: '0YqbK1nW+L+j3ppE7PHo3CvM/pNyHIDbNwYYvkKJGXU=',
					jiveUrl: 'https://sandbox.jiveon.com',
					timestamp: '2015-11-20T16:04:55.895+0000',
				}.to_json, @header_params

				# Success
				expect(response.code.to_i).to eq(204)
			end

			it 'should fail to unregister the addon when passed incorrect parameters' do
				post :destroy,
				{
					clientId: '2zm4rzr9aiuvd4zhhg8kyfep229p2gce.i',
					tenantId: 'b22e3911-28ef-480c-ae3b-ca791ba86952',
					jiveSignatureURL: 'https://market.apps.jivesoftware.com/appsmarket/services/rest/jive/instance/validation/8ce5c231-fab8-46b1-b8b2-fc65deccbb5d',
					clientSecret: 'evaqjrbfyu70jlvnap8fhnj2h5mr4vus.s',
					jiveSignature: '0YqbK1nW+L+j3ppE7PHo3CvM/pNyHIDbNwYYvkKJGXU=',
					jiveUrl: 'https://sandbox-bad.jiveon.com',
					timestamp: '2015-11-20T16:04:55.895+0000',
				}.to_json, @header_params
	
				# Success
				expect(response.code.to_i).to eq(403)
			end
		end
	end
end