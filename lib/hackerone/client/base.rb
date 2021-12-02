# frozen_string_literal: true

module HackerOne
  module Client
    class Base

      def initialize(hackerone_token_name: ENV["HACKERONE_TOKEN_NAME"], hackerone_token: ENV["HACKERONE_TOKEN"])
        @hackerone_token_name = hackerone_token_name
        @hackerone_token = hackerone_token

        unless @hackerone_token_name && @hackerone_token
          raise NotConfiguredError, "HACKERONE_TOKEN_NAME HACKERONE_TOKEN environment variables must be set"
        end
      end

      def hackerone_api_connection
        @connection ||= Faraday.new(url: "https://api.hackerone.com/v1") do |faraday|
          faraday.basic_auth(hackerone_token_name, hackerone_token)
          faraday.adapter Faraday.default_adapter
        end
      end

      private

      attr_reader :hackerone_token_name, :hackerone_token
    end
  end
end
