module Subl
  class Command
    attr_accessor :candidate, :line, :origial_binding

    def initialize(candidate:, line: nil, binding: nil)
      @candidate       = candidate
      @line            = line
      @origial_binding = binding
    end

    def call
      if path
        args = [path.strip, line].compact * ':'
        puts "open #{args}"
        system "subl #{args}"
      else
        puts "Couldn't open subl with #{candidate.inspect}"
      end
    end

    def path
      case candidate
      when String        then candidate
      when Symbol        then resolve_gem(candidate.to_s)
      when Class, Module then resolve_class(candidate)
      when Method        then resolve_method(candidate)
      when Regexp        then resolve_regexp(candidate)
      end
    end

    def resolve_method(m)
      loc = Array(m.source_location)
      self.line ||= loc.last
      loc.first
    end

    def resolve_class(klass)
      self.line = 0 # Prevent jumping to method
      resolve_class_by_class_method(klass) ||
        resolve_class_by_instance_method(klass)
    end

    def resolve_class_by_class_method(klass)
      m = klass.methods(false).first or return
      resolve_method(klass.method(m))
    end

    def resolve_class_by_instance_method(klass)
      m = klass.instance_methods(false).first or return
      resolve_method(klass.instance_method(m))
    end

    def resolve_regexp(r)
      m = origial_binding.methods.grep(r).first or return
      resolve_method(origial_binding.method(m))
    end

    def resolve_gem(name)
      result = `bundle show #{name}`
      result if $?.success?
    end
  end
end
