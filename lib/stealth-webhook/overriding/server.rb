# coding: utf-8
# frozen_string_literal: true
module Stealth
  class Server < Sinatra::Base

    post '/api/v1/webhook' do

      params = JSON.parse(request.body.read, :symbolize_names => true)
      Stealth::Logger.l(topic: 'webhook', message: "Webhook received data: #{params}")

      webhook = StealthWebhook::Webhook.new
      response_status, response_body = 503, 'Service Unavailable'
      response_status,response_body = webhook.send_message(params)

      status response_status
      body response_body
    end

  end
end
