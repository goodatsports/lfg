class Igdb::Requester
  class << self
    def request_headers
      Hash.new.tap do |headers|
        headers['Content-Type'] = 'text/json'
        headers['user-key'] = api.api_key
      end
    end
  end
end