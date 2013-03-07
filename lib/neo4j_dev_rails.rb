require 'neo4j_dev_rails/version'
require 'rest_client'

module Neo4jDevRails
  require File.expand_path('../neo4j_dev_rails/railtie', __FILE__) if defined?(Rails)

  def clean_neo4j
    response = RestClient.post 'http://localhost:7574/db/data/cypher', { query: 'START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx' }.to_json, accept: :json, content_type: :json
    response.code == 200
  end
end

# [ActiveSupport::TestCase, ActionDispatch::IntegrationTest].each do |klass|
#   klass.class_eval do
#     def clean_neo4j
#       response = RestClient.post 'http://localhost:7574/db/data/cypher', { query: 'START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx' }.to_json, accept: :json, content_type: :json
#       response.code == 200
#     end
#   end
# end
