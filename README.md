# Neo4jDevRails

Easy installation of a local Neo4j development and test server with a Rails development environment. Also provides some test helpers

## Installation

Add this line to your application's Gemfile:

    gem 'neo4j_dev_rails', git: 'git@github.com:dgroulx/neo4j_dev_rails.git'

And then execute:

    $ bundle

## Installing Neo4j

To download the Neo4j server, run:

	$ rake neo4j:install
	
This will create two directories, neo4j_dev, and neo4j_test, and leave the downloaded tarball behind. Future installs will first try and use this file if available.

## Running the Neo4j Server

This gem provides access to all of the neo4j executables commands via rake. To start the development database, simply run 
	
	$ rake neo4j:dev:start
	
This will start up a neo4j instance listening on port 7474. The test database will run on port 7574 by default.

## Testing with Neo4j

To clear out the test database after each test run, include the 'neo4j_dev_rails' file in the appropriate test helper, then call

	Neo4jDevRails::Test.clean_db

By default, this will clean the database running at http://localhost:7574. Both the host and port may be changed. For example, if you need to clean the database at http://myapp.dev:3600, be sure to run this code before any calls to Neo4jDevRails.clean_neo4j

	Neo4jDevRails.server = 'http://myapp.dev'
	Neo4jDevRails.port = 3600

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
