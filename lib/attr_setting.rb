require "attr_setting/version"

module AttrSetting
  def attr_setting(setting)
    attr_accessor setting
  end
end
