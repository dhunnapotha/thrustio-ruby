require 'rest-client'

module Thrust
  module AnyMail

    API_URL           = "https://thrust.io/api/v1/mail"
    SEARCH_URL        = "#{API_URL}/search"
    SEARCHES_LEFT_URL = "#{API_URL}/searchesLeft"

    class Client

      def initialize key
        @secret_key = key
      end

      def search name, domain
        params = build_search_params name, domain
        response = JSON.parse(RestClient.post SEARCH_URL, params)
        response['emails']
      end

      def searchesLeft
        params = build_serches_left_params
        response = JSON.parse(RestClient.post SEARCHES_LEFT_URL, params)
        response['searches'].to_i
      end

      private

      def build_serches_left_params
        {
          :key => @secret_key
        }
      end
      
      def build_search_params name, domain
        {
          :name => name,
          :domain => domain,
          :key => @secret_key
        }
      end
    end
  end
end