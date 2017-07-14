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

        attr_reader :scope_id, :id, :content

        def initialize(scope_id, id)
          @scope_id = scope_id
          @id = id
        end

        def content
          _content['content'] if content_is_ready?
        end

        def content_is_ready?
          _content && _content['scope_id'] == scope_id && _content['content']
        end

        private

        def storage
          @storage ||= InMemoryStorage.new
        end

        def _content
          @_content ||= storage.get(id)
          @content ||= JSON.parse(@_content) if @_content
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
