require 'rubygems'
require 'sinatra'
require 'haml'
require "#{File.dirname(__FILE__)}/../lib/payment"

get '/' do
  @payment = Payment.new(40, 'Inscripcio')
  @options = @payment.getOptions
  haml :index
end

post '/response' do

  payment = Payment.new
  if payment.verifyAcknowledge(request)
    if payment.isResponsePositive
      # Find payment.getOrderId and
      # mark your transaction as complete and positive
    else
      # Find payment.getOrderId and
      # mark your transaction as complete and failed.
      # You can get a more details version of the error by
      # using payment.getBankServerResponse() and Payment.getCodeResponseMeaning()
    end
  end
end

__END__

@@ index
!!! 5
%html
  %head  
    %title="Sample app"
  %body
    =@payment.form
    -@options.each_pair do |key,value| 
      =Payment.hidden_field(key,value)
    ="<input type='submit' value='Pay' />"
    </form>