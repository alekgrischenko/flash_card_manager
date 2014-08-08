#=begin
require 'aws'
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     FCManagerAWS.config['aws_access_key_id'],
    aws_secret_access_key: FCManagerAWS.config['aws_secret_access_key'],
    region:                FCManagerAWS.config['region'],   
    path_style: true,
  }               
  config.fog_directory  = FCManagerAWS.config['bucket_name']
end
#=end
