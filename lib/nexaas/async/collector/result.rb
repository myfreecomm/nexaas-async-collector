# Content is stored in the database as the following JSON:
# {
#   'scope_id' => 'scope_id',
#   'content' => 'generated content'
# }
# The content is scoped by scope, so any other scope who discover the key (id) of the content, will not be able
# to access only. Only the scope who created it.

module Nexaas
  module Async
    module Collector
      class Result

        attr_reader :scope_id, :id, :object

        def initialize(scope_id, id)
          @scope_id = scope_id
          @id = id
        end

        def content
          object['content'] if content_is_ready?
        end

        def content_is_ready?
          object && object['scope_id'] == scope_id && object['content']
        end

        def is_file?
          object && !object['file'].nil?
        end

        def filename
          object && object.dig('file', 'name')
        end

        def content_type
          object && object.dig('file', 'content_type')
        end

        def extension
          object && object.dig('file', 'extension')
        end

        private

        def storage
          @storage ||= InMemoryStorage.new
        end

        def object
          return @object if @object
          @_object = storage.get(id)
          @object = JSON.parse(@_object) if @_object
        end

        def url
          Nexaas::Async::Collector.redis_url
        end

        def namespace
          Nexaas::Async::Collector.redis_namespace
        end

      end
    end
  end
end
