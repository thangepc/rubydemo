OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1239004752798648', '6186aae05f9d116a4c449937f5eac1a6', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end