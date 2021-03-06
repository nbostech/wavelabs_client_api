require 'httmultiparty'

module WavelabsClientApi
  module Client
    module Api
      module Core
        class BaseApi

           include HTTMultiParty
           
           #debug_output $stdout

           headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'
           
           def base_api_url(uri)
           	 site_url + uri
           end
           	
           def site_url
             WavelabsClientApi.configuration.api_host_url	
           end

           def client_id
             WavelabsClientApi.configuration.client_key 
           end

           def client_secret
             WavelabsClientApi.configuration.client_secret
           end

           def self.check_connection?
             begin 
          	   res = self.get(WavelabsClientApi.configuration.api_host_url)
          	   if res.code == 200
          	   	true
          	   end
          	 rescue StandardError
                false
              end   	  	
           end	

           def send_request_with_token(method, url, access_token, body = nil, query = nil)
           	
           	 begin
           	  self.class.send(method, url, :body => body, :query => query, :headers => {"Authorization" => "Bearer " + access_token})
             rescue StandardError
             end

           end

           def send_request(method, url, body = nil, query_params = nil)
           	begin
           	 self.class.send(method, url, :body => body.to_json, :query => query_params)
            rescue StandardError
            end

           end 

           def create_login_model(login_params)
           	 WavelabsClientApi::Client::Api::DataModels::LoginApiModel.new(login_params)
           end

           def create_member_model(json_response, except_token)
             WavelabsClientApi::Client::Api::DataModels::MemberApiModel.new(json_response, except_token)
           end

           def create_token_model(json_response)
             WavelabsClientApi::Client::Api::DataModels::TokenApiModel.new(json_response)
           end 

           def create_media_model(json_response)
             WavelabsClientApi::Client::Api::DataModels::MediaApiModel.new(json_response)	
           end

           def create_message_model(json_response)	
             WavelabsClientApi::Client::Api::DataModels::MessageApiModel.new(json_response)	
           end

           def create_social_model(json_response)  
             WavelabsClientApi::Client::Api::DataModels::SocialAccountsApiModel.new(json_response) 
           end

           def create_token_details_model(json_response)
             WavelabsClientApi::Client::Api::DataModels::TokenDetailsApiModel.new(json_response)
           end 
        end
      end
    end
  end
end


