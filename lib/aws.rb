require 'yaml'
module FCManagerAWS
  CONFIG_PATH = File.join(Rails.root, 'config/aws.yml')

  def self.config
    @_config ||= YAML.load(ERB.new(File.read(CONFIG_PATH)).result)[Rails.env]
  end
end
