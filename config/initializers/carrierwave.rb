require 'dotenv' #'aws'
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'], #FCManagerAWS.config['aws_access_key_id'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], #FCManagerAWS.config['aws_secret_access_key'],
    region:                ENV['REGION'], #FCManagerAWS.config['region'],
    path_style: true,
  }
  config.fog_directory  = ENV['BUCKET_NAME'] #FCManagerAWS.config['bucket_name']
end
