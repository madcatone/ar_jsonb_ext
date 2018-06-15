class User < ApplicationRecord
  jattr_accessor *%i(enabled feedback_notifyees presentable_update_time)#, column: :meta
  soft_destroy
end
