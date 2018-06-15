class ApplicationRecord < ActiveRecord::Base
  include ArJsonbExt

  self.abstract_class = true
end
