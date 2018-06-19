class User < ApplicationRecord
  jattr_accessor *%i(code agent bio)#, column: :meta
  soft_destroy
end
