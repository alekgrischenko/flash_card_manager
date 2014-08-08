require 'yaml'
module FCManagerAWS
  CONFIG_PATH = File.join(Rails.root, 'config/aws.yml')

  def self.config
    @_config ||= YAML.load_file(CONFIG_PATH)[Rails.env]
  end
end
