module Concerns::Findable
  def find_by_name(name)
    self.all.detect {|element| element.name == name}
  end

  def find_or_create_by_name(name)
    found = find_by_name(name)
    if found
      found
    else
      self.create(name)
    end
  end
end
