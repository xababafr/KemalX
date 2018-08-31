require "./router"
require "./model"
require "./controller"

macro exec(instruction)
  {{instruction}}
end

router = KemalX::Router.new
router.import_yaml "src/routes.yml"

to_exec = %|
require "kemal"
require "./model"
require "./controller"
|

router.controllers.each do |mc_name|
  requires = %|
require "../models/#{mc_name}_model"
require "../controllers/#{mc_name}_controller"
|
  to_exec += requires
end

puts "Controllers and Models loaded : "
router.controllers.each do |mc|
  puts "    -- #{mc}"
end

to_exec += router.instructions
to_exec += "\nKemal.run"

puts "routes loaded : "
router.routes.each do |route, func|
  puts "    -- #{route}"
end

#puts "FILE TO WRITE : \n\n#{to_exec}"

File.write "src/.kemalx/main.cr", to_exec
