#require 'twilio-ruby'

def send_message(message, number)
  number = ("+1" + number.to_s)
  # this creates a new connection to the Twilio API
  @client = Twilio::REST::Client.new('ACed3ed813257f8acedfce46a695216257','cb1dd832eda91ea39319fe6827f1650b')

  # this creates a message and sends it out via Twilio
  @client.messages.create(
    from: '+14342605034', # this is the Flatiron School's Twilio number
    to: number,
    body: message
  )
end