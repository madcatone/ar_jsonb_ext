module ArJsonbExt
  # define soft destroy store in jsonb column default to `meta_info`
  #   e.g. => senior_leadership_caption_en free_text_box_body_zh=
  #  class User
  #    soft_destroy
  #    soft_destroy :jdeleted_at, scope: true, column: :meta_info
  #    soft_destroy :is_deleted
  #  end
  module SoftDestroy
    extend ActiveSupport::Concern

    included do
      class_eval do

        def delete
          self.destroy
        end

        def deleted?
          self.jdeleted_at.present?
        end

        def recover
          self.jdeleted_at = nil
          self.save(validate: false)
        end

      end #class_eval
    end #included

    module ClassMethods

      def soft_destroy(_attr=:jdeleted_at, options={})
        jattr_accessor _attr
        column = options[:column].present? ? options[:column] : :meta_info
        scope = options[:scope].present? ? options[:scope] : false

        default_scope do
          where("#{self.table_name}.#{column}->>'#{_attr}' is null")
        end if scope

        define_method "destroy" do
          self.send(:"#{column}")["#{_attr}"] = Time.current
          self.save(validate: false)
          self.__elasticsearch__.index_document if self.respond_to?(:__elasticsearch__)
        end

      end
    end #ClassMethods
  end #SoftDestroy
end #ArJsonbExt
