require 'active_model'

module Nexaas
  module Async
    module Collector
      class AsyncResource

        attr_accessor :scope_id, :class_name, :class_method, :args, :file, :collect_id

        include ActiveModel::Validations

        validates_presence_of :scope_id, :class_name, :class_method

        def initialize(opts={})
          opts.each do |key, value|
            self.send("#{key}=", value)
          end
        end

        def save!
          initialize_collect_id
          raise "Nexaas::Async::Collector: invalid fields #{errors.messages.keys.join(', ')}" unless valid?
          AsyncResourceJob.perform_async(sliced_attributes) 
        end

        def sliced_attributes
          {
            scope_id: scope_id, class_name: class_name, class_method: class_method,
            args: args, file: file, collect_id: collect_id
          }.reject { |_,v| v.nil? }
        end

        private

        def initialize_collect_id
          @collect_id ||= SecureRandom.hex(15)
        end
      end
    end
  end
end
