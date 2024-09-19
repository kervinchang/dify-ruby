# frozen_string_literal: true

require "net/http"
require "json"

module Dify
  class Client
    def initialize(api_key, base_url: "https://api.dify.ai/v1")
      @api_key = api_key
      @base_url = base_url.end_with?("/v1") ? base_url : "#{base_url}/v1"
    end

    def _send_request(method, endpoint, data = nil, params = nil, stream = false, &block)
      uri = URI.parse("#{@base_url}#{endpoint}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")

      headers = {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/json"
      }

      case method
      when "GET"
        uri.query = URI.encode_www_form(params) if params
        request = Net::HTTP::Get.new(uri.request_uri, headers)
      when "POST"
        request = Net::HTTP::Post.new(uri.request_uri, headers)
        request.body = data&.to_json
      else
        raise ArgumentError, "Unsupported HTTP method: #{method}"
      end

      if stream
        http.request(request) do |response|
          buffer = String.new
          response.read_body do |chunk|
            buffer << chunk
            while (line = buffer.slice!(/data: (.+)\n/))
              data = line.match(/data: (.+)\n/)[1]
              block.call(JSON.parse(data)) if block_given?
            end
          end
        end
      else
        http.request(request)
      end
    end

    def message_feedback(message_id, rating, user)
      data = {
        rating: rating,
        user: user
      }
      _send_request("POST", "/messages/#{message_id}/feedbacks", data)
    end

    def get_application_parameters(user)
      params = { user: user }
      _send_request("GET", "/parameters", nil, params)
    end
  end
end
