require 'httparty'
require 'credit_card_generator'

Quantity_to_generate = 10

def send_request(visa_numbers)
    visa_numbers.each do |visa_number|
        response = HTTParty.post('http://localhost:3000/login', 
            body: { 
                email: 'johndoe@gmail.com', 
                password: visa_number 
            }, 
            headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
    end
end

threads = []

10.times do
    threads << Thread.new do
        visa_numbers = CreditCardGenerator.generate('4', 16, Quantity_to_generate)
        send_request(visa_numbers)
    end
end

threads.each(&:join)