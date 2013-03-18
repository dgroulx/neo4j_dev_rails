module Neo4jDevRails
  module Test
    class Config
      attr_accessor :server, :port

      def initialize
        @server = 'localhost'
        @port = 7574
      end
    end
  end
end
