require "kemal"
require "yaml"

module KemalX

  def self.run
    Kemal.run
  end

  # takes a routes.yml file and create the routes
  class Router
    def import_yaml(path)
      routes_yaml = File.open(path)
      data = YAML.parse routes_yaml
      recursive_walk data.as_h, "/"
    end

    def recursive_walk(hash : Hash, url : String)
      hash.each do |key, value|
        if value.as_h?
        	recursive_walk value.as_h, url+key.as_s+"/"
        else
          add_route "#{url+key.as_s[1..-1]}", value.as_s
        end
      end
    end

    def add_route(url, func)
      url = url.gsub "/root", ""
      puts "adding route #{url} (#{func})"
      route url, func
    end

    macro route(url, func)
      get {{url}} do
        "Hello World!"
      end
    end

  end

end

router = KemalX::Router.new
router.import_yaml "src/routes.yml"
KemalX.run
