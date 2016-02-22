# This class is a virtual Model for TokenApiModel.
# It have required attributes to create the TokenApiModel object.


class WavelabsClientApi::Client::Api::DataModels::TokenApiModel
  attr_accessor :value, :expires_in, :refresh_token, :scope, :token_type

  def initialize(token_params = nil)
  	if token_params.present? 
	    @value = token_params["access_token"],
	    @expires_in = token_params["expires_in"],
	    @refresh_token = token_params["refresh_token"],
	    @scope = token_params["scope"],
	    @token_type = token_params["token_type"]
	end    
  end

end