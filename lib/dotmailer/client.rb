require 'cgi'
require 'json'
require 'restclient'

module Dotmailer
  class Client
    def initialize(api_user, api_pass)
      self.api_user = api_user
      self.api_pass = api_pass
    end

    def get_data_fields
      get 'data-fields'
    end

    private
    attr_accessor :api_user, :api_pass

    def get(path)
      JSON.parse RestClient.get url(path), :accept => :json
    end

    def url(path)
      URI::Generic.build(
        :scheme   => 'https',
        :userinfo => "#{CGI.escape(api_user)}:#{api_pass}",
        :host     => 'api.dotmailer.com',
        :path     => "/v2/#{path}"
      ).to_s
    end
  end
end
