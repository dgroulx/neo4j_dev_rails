require "neo4j_dev_rails/version"

module Neo4jDevRails
  require File.expand_path('../neo4j_dev_rails/railtie', __FILE__) if defined?(Rails)
end
