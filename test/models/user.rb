class User < ApplicationRecord
  jattr_accessor *%i(code agent bio)#, column: :meta
  soft_destroy :jdeleted_at, scope: true, column: :meta_info, method: :jsonb
end
