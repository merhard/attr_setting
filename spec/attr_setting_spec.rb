RSpec.describe AttrSetting do
  it 'has a version number' do
    expect(AttrSetting::VERSION).not_to be nil
  end

  describe '#attr_setting' do
    class Klass
      extend AttrSetting
      attr_setting :foo
    end

    let(:obj) { Klass.new }

    it 'creates accessor methods' do
      expect(obj.foo).to eq(nil)

      obj.foo = :bar

      expect(obj.foo).to eq(:bar)
    end
  end
end
