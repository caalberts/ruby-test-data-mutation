require './app'

describe 'testing with dependency pitfalls' do
  let(:data) { { a: 1, b: 2 } }
  let(:dependency) { double() }

  before do
    allow(dependency).to receive(:call).and_return(data)
  end

  describe 'asserting against a variable' do
    it 'does not catch mutations' do
      result = Service.new(dependency).exec()
      expect(result[:success]).to be(true)
      expect { expect(result[:data]).to eql(data) }.not_to raise_error
    end
  end

  describe 'asserting against literal values' do
    it 'catches mutations' do
      result = Service.new(dependency).exec()
      expect(result[:success]).to be(true)
      expect { expect(result[:data]).to eql(a: 1, b: 2) }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
