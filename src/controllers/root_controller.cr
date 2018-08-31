class RootController < KemalX::Controller

  def root(env)
    par = env.params.url["name"]
    names = RootModel.get_names
    render "src/views/root/hello.ecr", "src/views/layout.ecr"
  end

end
