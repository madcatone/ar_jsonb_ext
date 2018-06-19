class Company < ApplicationRecord
  jattr_accessor *%i(potential active)
  soft_destroy :deleted_at, method: :origin
end
