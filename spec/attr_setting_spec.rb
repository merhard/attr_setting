RSpec.describe AttrSetting do
  it 'has a version number' do
    expect(AttrSetting::VERSION).not_to be nil
  end

  describe '#attr_setting' do
    class Klass
      extend AttrSetting

      attr_setting :foo
      attr_setting :bar, :baz
    end

    let(:obj) { Klass.new }

    it 'creates accessor methods' do
      expect(obj.foo).to eq(nil)

      obj.foo = :bar

      expect(obj.foo).to eq(:bar)
    end

    it 'creates a predicate method' do
      expect(obj.foo?).to eq(false)

      obj.foo = :bar

      expect(obj.foo?).to eq(true)
    end

    it 'accepts a default value to the accessor as an argument' do
      expect(obj.bar).to eq(:baz)

      obj.bar = :foo

      expect(obj.bar).to eq(:foo)
    end
  end
end
