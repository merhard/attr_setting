require "attr_setting/version"

module AttrSetting
  def attr_setting(setting, default = nil)
    ivar = "@#{setting}"

    attr_writer setting

    define_method(setting) do
      if instance_variable_defined?(ivar)
        instance_variable_get(ivar)
      else
        instance_variable_set(ivar, default)
      end
    end

    define_method("#{setting}?") do
      !!send(setting)
    end
  end
end
