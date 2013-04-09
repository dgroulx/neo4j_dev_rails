require 'neo4j_dev_rails/version'
require 'neo4j_dev_rails/test'
require 'net/http'

module Neo4jDevRails
  require File.expand_path('../neo4j_dev_rails/railtie', __FILE__) if defined?(Rails)
end
