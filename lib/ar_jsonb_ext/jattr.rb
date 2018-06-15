require "active_support/concern"

module ArJsonbExt
  # define setters and getters store in jsonb column default to `meta_info`
  #   e.g. => senior_leadership_caption_en free_text_box_body_zh=
  #  class Deal
  #    jattr_accessor :weight, column: :physique
  #    jattr_accessor :name, i18n: true, method_prefix: :meta
  #  end
  module Jattr
    extend ActiveSupport::Concern

    included do

    end

    def get_jsonb_column(key, column=:meta_info)
      self.send(column)&.dig(key.to_s)
    end

    def update_jsonb_column(key, value, column=:meta_info)
      self.send(:"#{column}=", {}) if self.send(column).nil?
      self.send(column)[key.to_s] = value
    end

    module ClassMethods
      def jattr_reader(args)
        warp_json_attr_define(args) do |column, method_name, jsonb_key_name|
          define_method "#{method_name}" do
            get_jsonb_column(jsonb_key_name, column)
          end
        end
      end

      def jattr_writer(args)
        warp_json_attr_define(args) do |column, method_name, jsonb_key_name|
          define_method "#{method_name}=" do |attr_value|
            update_jsonb_column(jsonb_key_name, attr_value, column)
          end
        end
      end

      def warp_json_attr_define(args)
        options = args.extract_options!
        column  = options[:column] || :meta_info
        locales = options[:i18n] == true ? I18n.available_locales : [""]
        method_prefix = options[:method_prefix].present? ? "#{options[:method_prefix]}_" : ""
        args.each do |attr_name|
          locales.each do |locale|
            method_name = locale.present? ? "#{method_prefix}#{attr_name}_#{locale}" : "#{method_prefix}#{attr_name}"
            jsonb_key_name = locale.present? ? "#{attr_name}_#{locale}" : "#{attr_name}"
            yield(column, method_name, jsonb_key_name)
          end
        end
      end

      def jattr_accessor(*args)
        roptions, woptions = args, args.dup
        jattr_reader(roptions)
        jattr_writer(woptions)
      end

    end
  end #Jattr

end #ArJsonbExt
