require 'httparty'
require 'logger'
require 'json'


# curl -i -X POST \
#   https://graph.facebook.com/v15.0/100137039608242/messages \
#   -H 'Authorization: Bearer ' \
#   -H 'Content-Type: application/json' \
#   -d '{ "messaging_product": "whatsapp", "to": "", "type": "template", "template": { "name": "hello_world", "language": { "code": "en_US" } } }'

TOKEN = ""
SENDER_ID = "100137039608242"
BUSINESS_ID = "107766202165397"
RECIPIENT_ID = ""
BASE_URL = "https://graph.facebook.com/v15.0/" + SENDER_ID + "/messages"

LOG = Logger.new(STDOUT)

class WhatsAppClient
    include HTTParty


    def initialize

        data = {
            "messaging_product": "whatsapp",    
            "recipient_type": "individual",
            "to": RECIPIENT_ID,
            "type": "text",
            "text": {
                "preview_url": false,
                "body": "Hello World Subscribe"
            }
        }


        response = self.class.post(BASE_URL,
            body: (data),
            headers: {
                'Content-type' => "application/json",
                'Authorization' => "Bearer #{TOKEN}"
            }
        
        )

        @response_body = JSON.parse(response.body)
        
        LOG.info "#{@response_body}" if @response_body['error']


        @contacts = @response_body['contacts']
        @messages = @response_body['messages']

    end


    def details 
        {
            contacts: @contacts,
            messages: @messages
        }
    end
end


whatsapp = WhatsAppClient.new


p whatsapp.details
