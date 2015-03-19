require "attr_setting/version"

module AttrSetting
  def attr_setting(setting)
    attr_accessor setting

    ivar = "@#{setting}"
    define_method("#{setting}?") do
      if instance_variable_defined?(ivar)
        !!instance_variable_get(ivar)
      else
        false
      end
    end
  end
end
