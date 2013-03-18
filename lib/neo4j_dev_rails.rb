require 'neo4j_dev_rails/version'
require 'rest_client'

module Neo4jDevRails
  require File.expand_path('../neo4j_dev_rails/railtie', __FILE__) if defined?(Rails)

  def self.clean_neo4j
    response = RestClient.post "#{test_host}:#{test_port.to_s}/db/data/cypher", { query: 'START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx' }.to_json, accept: :json, content_type: :json
    return false unless response.code == 200

    # Clean out node indicies
    response = RestClient.get "#{test_host}:#{test_port.to_s}/db/data/index/node/", accept: :json
    JSON.parse(response.body).each do |index|
      debugger
      RestClient.delete "#{test_host}:#{test_port.to_s}/db/data/index/node/#{index}", accept: :json
    end
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
