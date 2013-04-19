neo4j_dev_root = 'neo4j_dev'
neo4j_test_root= 'neo4j_test'

namespace :neo4j do

  desc 'Download and install a neo4j server'
  task :install do
    basename = 'neo4j-community-1.8.2'
    tarball = "#{basename}-unix.tar.gz"

    puts 'Downloading Neo4j tarball...'
    %x{curl 'http://dist.neo4j.org/#{tarball}' > #{tarball}} unless File.file?(tarball)

    puts 'Unizpping Neo4j'
    %x{tar -xvf #{tarball}} unless File.directory?(basename)
    %x{mv #{basename} #{neo4j_dev_root}} unless File.directory?(neo4j_dev_root)
    %x{cp -R #{neo4j_dev_root} #{neo4j_test_root}} unless File.directory?(neo4j_test_root)

    puts 'Customizing Neo4j server settings'
    %x{ sed -i -e 's/7474/7574/g' #{neo4j_test_root}/conf/neo4j-server.properties }
    %x{ sed -i -e 's/7473/7573/g' #{neo4j_test_root}/conf/neo4j-server.properties }

    puts 'Adding the Neo4j server directories to your .gitignore file'
    [neo4j_dev_root, neo4j_test_root, tarball].each do |ignorefile|
      %x{ grep '#{ignorefile}' .gitignore }
      %x{ echo "\n#{ignorefile}" >> .gitignore } if $?.exitstatus == 1
    end

    %x{ rm -rf #{basename} }
  end


  %w(start stop restart status info install remove).each do |cmd|
    namespace :dev do
      desc "#{cmd.capitalize} the neo4j development server"
      task cmd do
        puts %x{#{neo4j_dev_root}/bin/neo4j #{cmd}}
      end
    end

    namespace :test do
      desc "#{cmd.capitalize} the neo4j test server"
      task cmd do
        puts %x{#{neo4j_test_root}/bin/neo4j #{cmd}}
      end
    end
  end


  namespace :dev do
    desc "Clear out the Neo4j Development Database"
    task :drop do
      Neo4jDevRails::Test.configure { |c| c.port = 7474 }
      Neo4jDevRails::Test.clean_db
    end
  end


  namespace :test do
    desc "Clear out the Neo4j Test Database"
    task :drop do
      Neo4jDevRails::Test.clean_db
    end
  end

end
