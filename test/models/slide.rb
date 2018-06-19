class Slide < ApplicationRecord
  jattr_accessor *%i(locale color size), column: :meta
  soft_destroy :deleted_at, column: :meta
end
