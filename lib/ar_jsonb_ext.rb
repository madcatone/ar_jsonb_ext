require "active_support/concern"
require "ar_jsonb_ext/version"
require "ar_jsonb_ext/jattr"
require "ar_jsonb_ext/soft_destroy"

module ArJsonbExt

  extend ActiveSupport::Concern

  include ArJsonbExt::Jattr
  include ArJsonbExt::SoftDestroy

  included do
  end

end

if defined?(Rails)
  module ArJsonbExt
    class Railtie < ::Rails::Railtie
      # initializer "ar_jsonb_ext.active_record" do
      #   ActiveSupport.on_load :active_record do
      #     require 'ar_jsonb_ext/orm/active_record'
      #   end
      # end
    end
    class ApplicationRecord < ActiveRecord::Base
      include ArJsonbExt

      self.abstract_class = true
    end
  end
end
