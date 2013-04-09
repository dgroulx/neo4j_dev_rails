require 'active_support/core_ext'

module Neo4jDevRails
  class Test
    include ActiveSupport::Configurable

    config_accessor :server, :port
    self.server = 'localhost'
    self.port = 7574

    def self.clean_db
      debugger
      http = Net::HTTP.new(Neo4jDevRails::Test.server, Neo4jDevRails::Test.port)
      req = Net::HTTP::Post.new('/db/data/cypher', {'Accpet' => 'application/json', 'Content-Type' => 'application/json'})
      req.body = { query: 'START n0=node(0),nx=node(*) MATCH n0-[r0?]-(),nx-[rx?]-() WHERE nx <> n0 DELETE r0,rx,nx' }.to_json
      res = http.request(req)

      # Clean out node indicies
      req = Net::HTTP::Get.new '/db/data/index/node', {'Accept' => 'application/json'}
      res = http.request(req)
      if res.code == "200"
        JSON.parse(res.body).each do |index|
          req = Net::HTTP::Delete.new "/db/data/index/node/#{index.first}", {'Application' => 'application/json'}
          res = http.request(req)
        end
      end
    end

  end
end
