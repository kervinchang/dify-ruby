# frozen_string_literal: true

module Dify
  class ChatClient < Client
    def create_chat_message(parameters = {}, &block)
      raise ArgumentError, "Invalid parameters" unless parameters.is_a?(Hash)
      raise ArgumentError, "Invalid user" unless parameters[:user]
      raise ArgumentError, "Invalid query" unless parameters[:query]

      parameters[:inputs] ||= {}
      parameters[:response_mode] ||= "streaming"
      stream = parameters[:response_mode] == "streaming"

      _send_request("POST", "/chat-messages", parameters, nil, stream, &block)
    end

    def get_conversation_messages(parameters = {})
      raise ArgumentError, "Invalid parameters" unless parameters.is_a?(Hash)
      raise ArgumentError, "Invalid user" unless parameters[:user]
      raise ArgumentError, "Invalid conversation_id" unless parameters[:conversation_id]

      _send_request("GET", "/messages", nil, parameters)
    end

    def get_conversations(parameters = {})
      raise ArgumentError, "Invalid parameters" unless parameters.is_a?(Hash)
      raise ArgumentError, "Invalid user" unless parameters[:user]

      _send_request("GET", "/conversations", nil, parameters)
    end

    def rename_conversation(parameters = {})
      raise ArgumentError, "Invalid parameters" unless parameters.is_a?(Hash)
      raise ArgumentError, "Invalid user" unless parameters[:user]
      raise ArgumentError, "Invalid conversation_id" unless parameters[:conversation_id]
      raise ArgumentError, "Invalid name" unless parameters[:name]

      _send_request("POST", "/conversations/#{parameters[:conversation_id]}/name", parameters)
    end
  end
end
