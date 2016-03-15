require 'spec_helper'

describe Subl::Command do
  let(:command) { Subl::Command.new(candidate: :foo) }

  describe '#resolve_gem' do
    it 'returns nil for non-exisiting gem' do
      expect(command.resolve_gem(:foo)).to eq nil
    end

    it 'returns a path for existing gems' do
      expect(command.resolve_gem(:rspec)).to include('/gems/rspec')
    end
  end

  describe '#resolve_class' do
    it 'sets the line to 0' do
      expect { command.resolve_class(Subl) }.to change { command.line }.from(nil).to(0)
    end

    it 'returns nil if class has no methods at all' do
      expect(command.resolve_class(A)).to eq nil
    end

    it 'returns path if class has class methods' do
      expect(command.resolve_class(B)).to end_with 'subl/spec/spec_helper.rb'
    end

    it 'returns path if class has instance methods' do
      expect(command.resolve_class(C)).to end_with 'subl/spec/spec_helper.rb'
    end

    it 'returns path if module has methods' do
      expect(command.resolve_class(D)).to end_with 'subl/spec/spec_helper.rb'
    end
  end

  describe '#resolve_method' do
    it 'returns nil if methods has no source location' do
      expect(command.resolve_method(''.method(:frozen?))).to eq nil
    end

    it 'returns path if source location is available' do
      expect(command.resolve_method(C.new.method(:foo))).to end_with 'subl/spec/spec_helper.rb'
    end
  end

  describe '#resolve_regexp' do
    it 'returns nil if no binding was given' do
      expect(command.resolve_regexp(/gem/)).to eq nil
    end

    it 'returns path if binding has matching method' do
      command.origial_binding = binding
      expect(command.resolve_regexp(/should/)).to include '/rspec/'
    end
  end
end
