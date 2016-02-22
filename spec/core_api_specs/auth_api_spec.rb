require 'spec_helper'

describe WavelabsClientApi::Client::Api::Core::AuthApi do

  user_params = {:username => "wavlelabstest", 
                          :password => "test123",
                          :email => "test@wavelabs.com",
                          :firstName => "w",
                          :lastName => "L"}

  let(:signup_user) {UserSignUp.sign_up_user(user_params)}
  let(:login_user) {UserSignUp.login_user}

	let (:auth_api_obj) { WavelabsClientApi::Client::Api::Core::AuthApi.new}
  let (:auth_api) { WavelabsClientApi::Client::Api::Core::AuthApi}

  it "#check_connection?" do
    expect(auth_api.check_connection?).to be true
  end 

  it "#Check Constants of Auth API URIS" do
  	expect(auth_api::LOGIN_URI).to eq '/api/v0/auth/login'
    expect(auth_api::LOGOUT_URI).to eq '/api/v0/auth/logout'
    expect(auth_api::CHANGE_PASSWORD_URI).to eq '/api/v0/auth/changePassword'
    expect(auth_api::FORGOT_PASSWORD_URI).to eq '/api/v0/auth/forgotPassword'
  end

  it "#login method without login details" do
  	res = auth_api_obj.login
  	expect(res[:status]).to eq 500
  	expect(res[:login].message).to eq "Invalid login parameters"
  end

  it "#login method with unregistered login details" do
  	res = auth_api_obj.login({:username => "test", :password => "pas"})
  	expect(res[:status]).to eq 400
  end

  it "#login method with registered login details" do
  	signup_user
  	res = auth_api_obj.login({:username => "wavlelabstest", :password => "test123"})
  	expect(res[:status]).to eq 200
  end

  it "Check Forgot Password with valid email#forgot_password" do
  	res = auth_api_obj.forgot_password({:email => "test@wavelabs.com"})
  	expect(res[:status]).to eq 200
  end

  it "Check Forgot Password with invalid email(#forgot_password)" do
  	res = auth_api_obj.forgot_password({:email => "test@labs.com"})
  	expect(res[:status]).to eq 400
  end

  it "Check Forgot Password with empty email(#forgot_password)" do
  	res = auth_api_obj.forgot_password({:email => " "})
  	expect(res[:status]).to eq 400
  end

  it "Check Change Password with invalid details(#change_password)" do
    l_req = login_user
    res = auth_api_obj.change_password({:password => "", :newPassword =>  " "},l_req[:member].token.value.first)
    expect(res[:status]).to eq 400
  end

  it "Check Logout(#logout)" do
  	l_req = login_user
  	res = auth_api_obj.logout(l_req[:member].token.value.first)
  	expect(res[:status]).to eq 200
  end	
  	
end
