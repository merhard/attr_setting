require "attr_setting/version"

module AttrSetting
  private

  def attr_setting(setting, default = nil)
    ivar = "@#{setting}"

    attr_writer setting

    define_method(setting) do |value = :_not_supplied|
      return instance_variable_set(ivar, value) unless value == :_not_supplied

      if instance_variable_defined?(ivar)
        instance_variable_get(ivar)
      else
        send("#{setting}!")
      end
    end

    define_method("#{setting}?") do
      !!send(setting)
    end

    define_method("#{setting}!") do
      default = instance_eval(&Proc.new) if block_given?
      instance_variable_set(ivar, default)
    end
  end
end
