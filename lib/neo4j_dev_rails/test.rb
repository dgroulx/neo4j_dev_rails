module Neo4jDevRails
  module Test
    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Neo4jDevRails::Test::Config.new
    end

    def self.clean_db
      http = Net::HTTP.new(Neo4jDevRails::Test.configuration.server, Neo4jDevRails::Test.configuration.port)
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
