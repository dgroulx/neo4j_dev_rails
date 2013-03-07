require 'neo4j_dev_rails/version'
require 'rest_client'

module Neo4jDevRails
  require File.expand_path('../neo4j_dev_rails/railtie', __FILE__) if defined?(Rails)

  def self.clean_neo4j
    response = RestClient.post "#{test_host}:#{test_port}/db/data/cypher", { query: 'START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx' }.to_json, accept: :json, content_type: :json
    response.code == 200
  end

  class << self
    attr_accessor :test_host, :test_port
  end

  def self.test_host
    @test_host ||= 'http://localhost'
  end

  def self.test_port
    @test_port ||= 7574
  end

end
