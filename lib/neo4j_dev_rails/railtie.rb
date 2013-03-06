module Neo4jDevRails
  class Railtie < Rails::Railtie
    rake_tasks do
      require File.expand_path('../../tasks/neo4j/neo4j', __FILE__)
    end
  end
end
