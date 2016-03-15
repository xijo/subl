require 'subl/version'
require 'subl/command'

class Object
  def subl(candidate = __dir__, line = nil)
    Subl::Command.new(candidate: candidate, line: line, binding: binding).call
  end
end
