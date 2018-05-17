module ArJsonbExt
  class ApplicationRecord < ActiveRecord::Base
    include ArJsonbExt
    # include ArJsonbExt::Jattr

    self.abstract_class = true
  end
end