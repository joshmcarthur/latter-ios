module Latter
  class API
    attr_reader :base_url, :params
    def initialize(auth_token = App::Persistence["auth_token"])
      @base_url = App::Persistence['api_endpoint'].tap do |hostname|
        hostname << '/api/'
        hostname << App::Persistence['api_version']
      end

      @params = {auth_token: auth_token}
    end

    def self.validate_token!(auth_token, &block)
      self.new(auth_token).get("/player.json") do |response|
        if response.nil? || response.status_code.nil? || response.status_code > 400
          block.call(false, auth_token, nil)
        else
          block.call(true, auth_token, BubbleWrap::JSON.parse(response.body)["player"]["id"])
        end
      end
    end

    def get(path, local_params = {}, &block)
      BubbleWrap::HTTP.get("#{base_url}#{path}", payload: params.merge(local_params), &block)
    end

    def post(path, local_params = {}, &block)
      BubbleWrap::HTTP.post("#{base_url}#{path}", payload: params.merge(local_params), &block)
    end
  end
end