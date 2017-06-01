# Content is stored in the database as the following JSON:
# {
#   'user_id' => 'user_id',
#   'content' => 'generated content'
# }
# The content is scoped by user, so any other user who discover the key (id) of the content, will not be able
# to access only. Only the user who created it.
# Maybe leave this more generic?

module Nexaas
  module Async
    module Collector
      class Result

        attr_reader :user_id, :id, :content

        def initialize(user_id, id)
          @user_id = user_id
          @id = id
        end

        def content
          _content['content'] if content_is_ready?
        end

        def content_is_ready?
          _content && _content['user_id'] == user_id && _content['content']
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
          Nexaas::Async::Collector.configuration.redis_url
        end

        def namespace
          Nexaas::Async::Collector.configuration.redis_namespace
        end

      end
    end
  end
end
