class RootModel < KemalX::Model

  def self.get2(i)
    if i > 2
      i
    else
      2
    end
  end

end
