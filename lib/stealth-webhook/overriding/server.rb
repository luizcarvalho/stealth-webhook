# coding: utf-8
# frozen_string_literal: true
module Stealth
  class Server < Sinatra::Base

    post '/api/v1/webhook' do

      params = JSON.parse(request.body.read, :symbolize_names => true)
      Stealth::Logger.l(topic: 'webhook', message: "Webhook received data: #{params}")

      response_status, response_body = send_message(params, request.env['HTTP_AUTHORIZATION'])

      status response_status
      body response_body
    end


    def send_message(params, auth_token = nil)
      return [401, 'Unauthorized: Invalid Token'] if ENV['WEHBOOK_AUTH_TOKEN'] && auth_token != "Token #{ENV['WEHBOOK_AUTH_TOKEN']}"

      begin
        webhook = StealthWebhook::Webhook.new
        webhook.send_message(params)
      rescue => e
        [503, "Service Unavailable: #{e.message}"]
      end
    end

  end
end
