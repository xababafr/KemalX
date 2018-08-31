
require "kemal"
require "./model"
require "./controller"

require "../models/RootModel"
require "../controllers/RootController"

require "../models/BlogModel"
require "../controllers/BlogController"

get "/" do
  RootController.root
end

get "/blog/" do
  BlogController.root
end

get "/blog/posts/" do
  BlogController.posts_list
end

get "/blog/posts/list/" do
  BlogController.posts_list
end

get "/blog/posts/add/" do
  BlogController.posts_add
end

Kemal.run