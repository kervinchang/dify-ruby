# frozen_string_literal: true

module Dify
  class CompletionClient < Client
    def create_completion_message(parameters = {}, &block)
      raise ArgumentError, "Invalid parameters" unless parameters.is_a?(Hash)
      raise ArgumentError, "Invalid user" unless parameters[:user]
      raise ArgumentError, "Invalid inputs" unless parameters[:inputs]

      parameters[:response_mode] ||= "streaming"
      stream = parameters[:response_mode] == "streaming"
      _send_request("POST", "/completion-messages", parameters, nil, stream, &block)
    end
  end
end
