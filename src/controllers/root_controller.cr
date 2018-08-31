class RootController < KemalX::Controller

  def root(env)
    nbr = RootModel.get2 3
    name = "#{env.params.url["name"]}_#{nbr}"
    render "src/views/root/hello.ecr", "src/views/layout.ecr"
  end

end
