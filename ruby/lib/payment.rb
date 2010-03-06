require 'YAML'
require 'ERB'
require 'digest/sha1'
require 'constants'
class Payment


  def initialize(amount='', description='', order_id='')
    #Payment properties
    @amount = ''
    @description = ''
    @currency = CURRENCY_EUR
    @terminal = 1
    @transaction_type = 0
    @signature = ''
    @merchant_code = ''
    @key = ''
    @language = LANG_CATALAN
    @notification_url = ''
    @KO_url = ''
    @OK_url = ''
    @merchant_name = ''
    #Loaded configuration
    @config = ''
    @unknown_properties = []

    #This variable is set after verifing Acknowledge message
    @bank_server_response = ''
    
    
    load_config()
    setAmount(amount)
    @description = description
    @order_id = getOrderId(order_id)
    @tpvurl = TPV_PRODUCTION_MODE ? 'https://sis.sermepa.es/sis/realizarPago' : 'https://sis-t.sermepa.es:25443/sis/realizarPago'
  end
  
  #Available properties to be loaded from config file
  def self.getProperties
    ['currency' , 'terminal' , 'transaction_type', 'merchant_code', 'key' , 'language' , 'notification_url', 'KO_url' , 'OK_url' , 'merchant_name']
  end
  #Acknowledge fields that must be received
  def self.getAcklogedgeFields
    ['Ds_Amount', 'Ds_Order', 'Ds_MerchantCode', 'Ds_Currency', 'Ds_Response' , 'Ds_Signature']
  end
  #Posible responses from the bank
  def self.getCodeResponseMeaning
     {
       '0-99' => 'Transaction authorised for payments and pre-authorisations',
       '0900' => 'Transaction authorised for refunds and confirmations',
       '101' => 'Card expired',
       '102' => 'Card temporarily suspended or under suspicion of fraud',
       '104' => 'Transaction not allowed for the card or terminal',
       '116' => 'Insufficient funds',
       '118' => 'Card not registered',
       '129' => 'Security code (CVV2/CVC2) incorrect',
       '180' => 'Card not recognised',
       '184' => 'Cardholder authentication failed',
       '190' => 'Transaction declined without explanation',
       '191' => 'Wrong expiration date',
       '202' => 'Card temporarily suspended or under suspicion of fraud with confiscation order',
       '912' => 'Issuing bank not available',
       '9912' => 'Issuing bank not available',
       'else' => 'Transaction declined'
    }
  end
  def self.sha1 value
    return Digest::SHA1.hexdigest(value)
  end
  #Acknowledgement message functions
  def verifyAcknowledge(post)
    Payment.getAcklogedgeFields.each {|field| return false unless post.key?(field)}

    @bank_server_response = post["Ds_Response"]
    message = Payment.sha1("#{post['Ds_Amount']}#{post['Ds_Order']}#{post['Ds_MerchantCode']}#{post['Ds_Currency']}#{post['Ds_Response']}#{@key}");
    @amount = post["Ds_Amount"]
    setOrderId(post["Ds_Order"])
    setCurrency(post["Ds_Currency"])
    return post["Ds_Signature"] == message
  end
  def getBankServerResponse
    return @bank_server_response.empty? ? -1 : @bank_server_response
  end
  def isResponsePositive
    # This function return true if Bank response is 0-99 or 0900
    response = getBankServerResponse()*1
    return (response.to_i >= 0 && response.to_i <= 99) || getBankServerResponse == '0900' ?  true : false
  end
  def setBankServerResponse(code)
    !TPV_TEST_MODE && raise('This function is only for testing purpose')
    @bank_server_response = code
  end
  #Options setter functions
  def setNotificationUrl(value)
    @notification_url = /^(http|https)\:\/\/(.*)/.match(value) ? value : "http://#{value}"
  end
  def setAmount(value)
    @amount = (value.to_f * 100).to_i.to_s
  end
  def setMerchantCode(value)
    @merchant_code = value
  end
  def setKey(value)
    @key = value
  end
  def setKoUrl(value)
    @KO_url = value
  end
  def setOkUrl(value)
    @OK_url = value
  end
  def setMerchantName(value)
    @merchant_name = value
  end
  def setLanguage(value)
    @language = value
  end
  def setOrderId(value)
    @order_id = value
  end
  def setCurrency(value)
    @currency = value
  end
  #Options getter functions
  def getNotificationUrl
    return @notification_url
  end
  def getMustOptions
    {
      'Ds_Merchant_Amount'=>             @amount,          
      'Ds_Merchant_Currency'=>            @currency,        
      'Ds_Merchant_Order'=>               getOrderId,       
      'Ds_Merchant_ProductDescription'=>  @description,     
      'Ds_Merchant_MerchantCode' =>        @merchant_code,   
      'Ds_Merchant_MerchantSignature' =>   getSignature,     
      'Ds_Merchant_Terminal' =>            @terminal,        
      'Ds_Merchant_TransactionType' =>     @transaction_type,
      'Ds_Merchant_ConsumerLanguage' =>     @language
    }
  end
  def getOptionalOptions
    {
      'Ds_Merchant_Titular'      => @merchant_name,   
      'Ds_Merchant_MerchantURL'  => @notification_url,
      'Ds_Merchant_UrlKO'        => @KO_url,          
      'Ds_Merchant_UrlOK'        => @OK_url          
    }.delete_if {|key, value| value.empty? }
  end
  def getOptions
    return getOptionalOptions.merge(getMustOptions)
  end
  def getAmount
    return @amount
  end
  def getHumanizedAmount
    return getAmount.to_f / 100
  end
  def getDescription
    return @description
  end
  def getOrderId(order_id='')
    @order_id ||= order_id.empty? ? Time.now.strftime('%Y%m%d%H%i%s') : order_id
    return @order_id
  end
  def getSignature
    if @signature.empty?
      #Ds_Merchant_Amount + Ds_Merchant_Order +Ds_Merchant_MerchantCode + DS_Merchant_Currency +Ds_Merchant_TransactionType +	Ds_Merchant_MerchantURL + CLAVE SECRETA
      @signature = Payment.sha1("#{getAmount}#{getOrderId}#{@merchant_code}#{@currency}#{@transaction_type}#{getNotificationUrl}#{@key}")
    end
    return @signature
  end
  def getCurrency(value)
    return @currency
  end
  #Form helpers
  def self.hidden_field(name,value)

    return "<input type='hidden' value='#{value}' name='#{name}' id='#{name}' />";
  end
  def form
    form = "<form action='#{@tpvurl}' method='post' >\n"
  end
private
  def load_config
    if(@config.empty?)
      file = TPV_CONFIG_DIR+DS+'tpv.yml'
      raise 'tpv.yml is missing' unless File.exist?(file)
      @config = YAML::load(ERB.new(IO.read(file)).result)
      @config.each_pair do |conf, value|
        if Payment.getProperties.include?(conf)
          (conf=='language' || conf=='currency') && eval("defined?(#{value})") == 'constant' && value = eval("#{value}")
          eval("@#{conf} = value")
          puts eval("@#{conf}")
        else
          @unknown_properties << conf
        end
      end
    end
    @unknown_properties.size
  end
end
class Object
  def is_numeric?
    false
  end
end

class Fixnum
  def is_numeric?
    true
  end
end