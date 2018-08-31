class RootController < KemalX::Controller

  def root(env)
    name = env.params.url["name"]
    render "src/views/root/hello.ecr", "src/views/layout.ecr"
  end

end
