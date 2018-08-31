require "kemal"
require "yaml"

module KemalX

  # def self.run
  #   Kemal.run
  # end

  # takes a routes.yml file and gather the infos
  class Router
    getter controllers, routes, instructions

    def initialize
      @instructions = ""
      @controllers = [] of String
      @routes = {} of String => Array(String) # route => controller_method to call
    end

    def import_yaml(path)
      routes_yaml = File.open(path)
      data = YAML.parse routes_yaml
      data.as_h.each do |controller, hash|
        @controllers << controller.as_s
      end
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
      mc = url.split('/')[1].split(':')[0]
      if mc == ""
        mc = "root"
      end
      @routes[url] = [mc,func]
      instructions = routing_instructions url, mc.capitalize, func
      @instructions += instructions
    end

    def routing_instructions(url, controller, func)
      %|
get "#{url}" do \|env\|
  c = #{controller}Controller.new
  c.#{func} env
end
|
    end

  end

end
