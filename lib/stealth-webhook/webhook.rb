module StealthWebhook
  class Webhook
    attr_reader :errors
    StructUser = Struct.new(:fb_id)

    def initialize
      @errors = {}
    end

    def send_message(params)
        if validate_and_send_message(params)
           [200, { message: 'Message sent with success' }]
        else
          [@errors[:status], @errors.to_json]
        end
      rescue => e
        [500, { message: e.message }]
    end


    def validate_and_send_message(params)
      return unless validate(params)
      user = recipient(params)
      return unless user

      deliver(user.fb_id, params[:message])
    end

    def deliver(recipient, message)
      Stealth::ScheduledReplyJob.perform_in(0, 'facebook', recipient, 'webhook', 'say_notification', message)
      true
    end


    private


    def validate(params)

      unless params[:recipient].respond_to?(:dig)
        @errors = {message: ":recipient must be a hash : #{params[:recipient].inspect}", code: 400, status: :bad_request}
        return
      end

      unless params.dig(:recipient, :assistido_id) || params.dig(:recipient, :assistido_cpf) || params.dig(:recipient, :fb_id)
        @errors= {message: ':recipient must have the follow keys: assistido_id ou assistido_cpf', code: 400, status: :bad_request}
        return
      end
      true
    end

    def recipient(params)

      if params.dig(:recipient, :fb_id)
        user = StructUser.new(params.dig(:recipient, :fb_id))
      else
        query_params = {
          solar_id: params.dig(:recipient, :assistido_id),
          cpf: params.dig(:recipient, :assistido_cpf)
        }.compact

        user = User.where(query_params).first
      end

      @errors= {message: "recipient not found: #{query_params.to_json})", code: 404, status: :not_found} unless user
      user
    end

  end
end