%w(rubygems YAML ERB digest/sha1 haml).each{|lib| require lib}
%w(constants util).each{|file| require "#{File.dirname(__FILE__)}/#{file}"}


class CustomPaymentHelpers
  def initialize
    haml = Object.new
    class << haml
      include Haml::Helpers
    end
    @haml = haml
    @haml.init_haml_helpers
  end
  def haml
    @haml
  end
  #helpers
  def hidden_field(name,value)
    id, name = tag_values(name)
    haml.haml_tag :input, {:type => 'hidden', :value => value, :name => name, :id => id}
  end
  def text_field(name,value)
    id, name = tag_values(name)
    haml.haml_tag :input, {:type => 'text', :value => value, :name => name, :id => id}
  end
  def select_field(name,values={})
    id, name = tag_values(name)
    if values.array?
      options = values
      values = {}
      options.each do |opt|
        values[opt] = opt
      end
    end
    haml.haml_tag :select,{:name => name, :id => id} do
      values.keys.sort.each do |key|
        haml.haml_tag :option, {:value => values[key]} do
          haml.haml_concat key
        end
      end
    end
  end
  def date_fields(name,options={})
    years = []
    options = {:year => Time.now.strftime('%Y').to_i}.merge(options)
    options[:year].to_i.upto(options[:year].to_i+7){|y| years << y }
 
    select_field({:model => name[:model], :field_name => "#{name[:name]}_year" }, years)
    select_field({:model => name[:model], :field_name => "#{name[:name]}_month"}, (1..12).to_a.sort)
  end
  
  private
  def tag_values(name)
    if name.string?
      id = name 
    else
      id = "#{name[:model]}_#{name[:field_name]}"
      name = "#{name[:model]}['#{name[:field_name]}']"
    end
    return id, name
  end
end

class PaymentValidation
  include TPV::Crypt
  include TPV::Config
  include TPV::Bbva
  attr_accessor :terminal, :merchant_code, :tpvurl, :currency, :reference, :notification_url, :language, :keycode
  attr_reader :dark_key
  def initialize(fields,options={})
    options = {:load_config => {}}.merge(options)
    @fields = fields.keyfy!
    if all_expected_fields_received?
      @fields[:importe].sub!(',','.')
      valid_format_response? && @fields[:estado] = @fields[:estado].to_i
    end
    @config = ''
    @unknown_properties = []
    load(options[:load_config])

  end
  
  def validate_response
    if well_formated_response?
      valid_format_response? ? (positive_response? ? positive_response : rejected_operation_response) : format_error_response
    else
      fake_response
    end
  end

  def self.format_less_amount value
    (value.to_f * 100).to_i.to_s
  end

  private
  #Does all fields needed to calculate signature are present on the response?
  def all_expected_fields_received?
    @signature_fields ||= %w(idterminal idcomercio idtransaccion importe moneda coderror codautorizacion firma).map{|value| value = value.to_sym}
    !@fields.empty? && @fields.areset?(@signature_fields)
  end
  #Do we receive all expected fields and from a valid source(signed content)
  def well_formated_response?
    all_expected_fields_received? && validate_bank_response_signature
  end
  def calculate_bank_signature
    # When invalid format response, 'estado' is not received, 
    # so lets put empty string on its place.
    status = valid_format_response? ? @fields[:estado] : ''
    #Amount should be formated without , nor . and 2 decimal digits
    amount = PaymentValidation.format_less_amount(@fields[:importe])
    TPV::Crypt::sha1("#{@fields[:idterminal]}#{@fields[:idcomercio]}#{@fields[:idtransaccion]}#{amount}#{@fields[:moneda]}#{status}#{@fields[:coderror]}#{@fields[:codautorizacion]}#{deofuscate_key}")
  end
  
  def validate_bank_response_signature
    #Does received signature is the expected one? 
    @fields[:firma] == calculate_bank_signature
  end
  
  def positive_response?
    @fields[:estado] == Statuses::ACCEPTED && %w(0000 000).include?(@fields[:coderror])
  end
  def valid_format_response?
    @fields.key?(:estado)
  end

  # Response format functions
  def positive_response
    {:response => Responses::VALID, :message => :successful_operation}
  end
  def format_error_response
    {:response => Responses::UNFORMATED, :message => "Format error: #{@fields[:deserror]}"}
  end
  def rejected_operation_response
    {:response => Responses::REJECTED, :message => "Rejected operation: #{@fields[:deserror]}"}
  end
  def fake_response
    {:response => Responses::FAKE, :message => "This message occurs when response is not from the bank or a valid source"}
  end
end

class CustomPayment

  include TPV::Crypt
  include TPV::Config
  include TPV::Base
  include TPV::Bbva
  attr_accessor :terminal, :merchant_code, :tpvurl, :currency, :reference, :notification_url, :language, :keycode
  attr_reader :amount, :dark_key
  alias_method :non_formated_amount, :amount
  def initialize(given_amount, options={})
    options = {:order_id => '', :load_config => {}}.merge(options)
    #Payment properties
    @amount = ''
    @description = ''
    @currency = Currencies::EUR
    @terminal = 1
    @transaction_type = 0
    @signature = ''
    @merchant_code = ''
    @key = ''
    @language = Languages::CATALAN
    @notification_url = ''
    @KO_url = ''
    @OK_url = ''
    @merchant_name = ''
    @reference = ''
    #Loaded configuration
    @config = ''
    @unknown_properties = []

    #This variable is set after verifing Acknowledge message
    @bank_server_response = ''
    
    #Loading data
    load(options[:load_config])
    send :amount=, given_amount
    order_id(options[:order_id])
  end
  def self.fields
    {:numtarjeta => :text, :fechacaducidad => :date, :cvv2 => :text, :modelopago => :hidden, :idterminal => :hidden, :idcomercio => :hidden, :idtransaccion => :hidden, :mediopago => :hidden, :soporte => :hidden, :canal => :hidden, :moneda => :hidden, :importe => :hidden, :urlcomercio => :hidden, :localizador => :hidden, :firma => :hidden}
  end
  def public_fields_values(options={})
    options = {:force => false}.merge(options)
    options[:force] && @fields_value = fields_values
    @fields_value ||= fields_values
  end
  def order_id(order_identifier='')
    @order_id ||= order_identifier.empty? ? Time.now.strftime('%y%m%d%H%M%S') : order_identifier
    return @order_id
  end
  def amount= value
    @amount = (value.to_f * 100).to_i.to_s
  end
  def formated_amount
    (amount.to_f / 100).to_f
  end
  def payment_signature
    @signature.empty? && @signature = TPV::Crypt::sha1("#{terminal}#{merchant_code}#{order_id}#{non_formated_amount}#{currency}#{reference}#{deofuscated_key}")
    return @signature
  end
  private
  def fields_values
    { :modelopago => 4, :idterminal => terminal, :idcomercio => merchant_code, :idtransaccion => order_id, :mediopago => 4, :soporte => 1, :canal => 1, :moneda => currency, :importe => formated_amount, :urlcomercio => notification_url, :localizador => reference, :firma => payment_signature }
  end

end