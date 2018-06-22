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

      end #class_eval
    end #included

    def action_method(_action, _attr)
      case _action
      when :delete
        self.send(:"#{_attr}=", Time.current)
        self.save(validate: false)
        self.__elasticsearch__.index_document if self.respond_to?(:__elasticsearch__)
      when :deleted?
        self.send(:"#{_attr}").present?
      when :recover
        self.send(:"#{_attr}=", nil)
        self.save(validate: false)
      else
        nil
      end
    end

    module ClassMethods

      def soft_destroy(_attr=:jdeleted_at, options={})
      # def soft_destroy(*_attr)
        # options = _attr.extract_options!
        _column = options[:column] || :meta_info
        _scope = options[:scope] || true
        _method = options[:method] || :jsonb

        case _method
        when :jsonb
          jattr_accessor _attr, column: _column
          default_scope { where("#{self.table_name}.#{_column}->>'#{_attr}' is null") }
        when :origin
          default_scope { where("#{self.table_name}.#{_attr} is null") }
        else
          nil
        end

        self.default_scopes = [] if _scope == false

        [:delete, :deleted?, :recover].each do |_action|
          define_method _action do
            action_method(_action, _attr)
          end
        end

        alias_method :soft_destroyed?, :deleted?
        alias_method :destroy, :delete
      end
    end #ClassMethods
  end #SoftDestroy
end #ArJsonbExt
