
require "kemal"
require "./model"
require "./controller"

require "../models/root_model"
require "../controllers/root_controller"

require "../models/blog_model"
require "../controllers/blog_controller"

get "/:name" do |env|
  c = RootController.new
  c.root env
end

get "/blog/" do |env|
  c = BlogController.new
  c.root env
end

get "/blog/posts/" do |env|
  c = BlogController.new
  c.posts_list env
end

get "/blog/posts/list/" do |env|
  c = BlogController.new
  c.posts_list env
end

get "/blog/posts/add/" do |env|
  c = BlogController.new
  c.posts_add env
end

Kemal.run