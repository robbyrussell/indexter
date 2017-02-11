module Indexter
  class Railtie < Rails::Railtie
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each do |file|
        puts ">> #{file}"
        load file
      end
    end
  end
end
