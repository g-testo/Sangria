if Rails.env.production?
  CarrierWave.configure do |config|
    config.root = Rails.root
    config.fog_provider = 'fog/aws'                        # required
    
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:      ENV["AWS_ACCESS_KEY"] ,                        # required
      aws_secret_access_key:  ENV["AWS_SECRET_KEY"] ,                        # required
      region:                'us-east-1',                  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = 'sangriawebsite'                          # required
  end
end