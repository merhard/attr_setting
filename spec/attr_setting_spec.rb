RSpec.describe AttrSetting do
  it 'has a version number' do
    expect(AttrSetting::VERSION).not_to be nil
  end

  describe '#attr_setting' do
    let(:klass) { Class.new { extend AttrSetting } }
    let(:obj)   { klass.new }

    it 'creates accessor methods' do
      klass.class_eval { attr_setting :foo }

      expect(obj.foo).to eq(nil)

      obj.foo = :bar

      expect(obj.foo).to eq(:bar)
    end

    it 'creates a predicate method' do
      klass.class_eval { attr_setting :foo }

      expect(obj.foo?).to eq(false)

      obj.foo = :bar

      expect(obj.foo?).to eq(true)
    end

    it 'accepts a default value to the accessor as an argument' do
      klass.class_eval { attr_setting :foo, :bar }

      expect(obj.foo).to eq(:bar)
    end

    it 'accepts a default value to the accessor as a block' do
      klass.class_eval { attr_setting(:foo) { :bar } }

      expect(obj.foo).to eq(:bar)
    end

    it 'evaluates block defaults lazily' do
      klass.class_eval do
        attr_setting :foo, "Initial"
        attr_setting(:bar) { foo }
      end

      obj.foo = "New Value"

      expect(obj.bar).to eq("New Value")
    end

    it 'allows default value to be reset' do
      klass.class_eval { attr_setting :foo, :bar }

      obj.foo = :baz
      obj.foo!

      expect(obj.foo).to eq(:bar)
    end

    it 'reevaluates block when reset' do
      klass.class_eval do
        attr_setting :foo, "Initial"
        attr_setting(:bar) { foo }
      end

      expect(obj.bar).to eq("Initial")

      obj.foo = "New Value"

      expect(obj.bar).to eq("Initial")

      obj.bar!

      expect(obj.bar).to eq("New Value")
    end
  end
end
