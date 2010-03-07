require 'rubygems'
require 'sinatra'
require 'haml'
require "#{File.dirname(__FILE__)}/../lib/payment"

get '/' do
  @payment = Payment.new(40, 'Inscripcio')
  @options = @payment.getOptions
  haml :index
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