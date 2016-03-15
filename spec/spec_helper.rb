$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'subl'

class A
end

class B
  def self.foo
  end
end

class C
  def foo
  end
end

module D
  def foo
  end
end
