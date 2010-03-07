TPV_MODE = 'test'
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/payment"

class TestOfPayment < Test::Unit::TestCase
    
    def test_PaymentHasMinimalFields
      payment = Payment.new(20,'Inscripcio')
      id = payment.getOrderId
      assert_equal(id,Time.now.strftime('%y%m%d%H%M%S'))
      assert_equal(payment.getAmount,"2000")
      assert_equal(payment.getDescription,'Inscripcio')
      assert_equal(9, payment.getOptions.size)
      #this last asertion can fail if notification_url or other optional setting is set in tpv.yml file
    end
    def test_PaymentHasOptionalFields
      payment = Payment.new(20,'Inscripcio')
      assert_equal(9, payment.getOptions.size)
      payment.setMerchantName('Unió Excursionista de Sabadell')
      assert_equal(10, payment.getOptions.size )
      payment.setNotificationUrl('testing value')
      assert_equal(11, payment.getOptions.size)
      payment.setOkUrl('ok url')
      assert_equal(12, payment.getOptions.size)
      payment.setKoUrl('ko url')
      assert_equal(13, payment.getOptions.size)
    end
    def test_GetHtmlHiddenFieldAndForm
      payment = Payment.new(20,'Inscripcio')
      assert_equal "<form action='https://sis-t.sermepa.es:25443/sis/realizarPago' method='post' >\n", payment.form
      
      expected_field = "<input type='hidden' value='2000' name='Ds_Merchant_Amount' id='Ds_Merchant_Amount' />"
      options = payment.getOptions
      option = options.first
      given_field = Payment.hidden_field(option[0],option[1])
      assert_equal given_field, expected_field
    end
    def test_payment_amount
      payment = Payment.new(12.35,'Inscripcio','29292929')
      assert_equal('1235',payment.getAmount)
      payment.setAmount(12)
      assert_equal('1200',payment.getAmount)
      payment.setAmount(120)
      assert_equal('12000',payment.getAmount)
      payment.setAmount(120.3)
      assert_equal('12030',payment.getAmount)
      payment.setAmount(120.21)
      assert_equal('12021',payment.getAmount)
      
      payment.setAmount('12.35')
      assert_equal('1235',payment.getAmount)
      payment.setAmount('12')
      assert_equal('1200',payment.getAmount)
      payment.setAmount('120')
      assert_equal('12000',payment.getAmount)
      payment.setAmount('120.3')
      assert_equal('12030',payment.getAmount)
      payment.setAmount('120.21')
      assert_equal('12021',payment.getAmount)
    end
    def test_set_merchant_url
      payment = Payment.new(1235,'Inscripcio','29292929')
      payment.setNotificationUrl('test.cat')
      assert_equal(payment.getNotificationUrl,'http://test.cat')
      payment.setNotificationUrl('http://www.test.cat')
      assert_equal(payment.getNotificationUrl,'http://www.test.cat')
    end
    def test_signature
      payment = Payment.new(1235,'Inscripcio','29292929')
      payment.setKey('h2u282kMks01923kmqpo')
      payment.setMerchantCode('201920191')
      payment.setNotificationUrl('http://www.test.cat')
      $resultat = 'b7571e2de2c2d0b7a8064f5fa620ef4426a01352'
      $cadena = Payment.sha1('123500292929292019201919780http://www.test.cath2u282kMks01923kmqpo')
      assert_equal(payment.getSignature,$resultat)
      assert_equal($cadena,$resultat)
    end
    def test_humanized_amount
    
      payment = Payment.new(12.35,'Inscripcio','29292929')
      assert_equal(12.35,payment.getHumanizedAmount)
      payment.setAmount(12)
      assert_equal(12.00,payment.getHumanizedAmount)
      payment.setAmount(120)
      assert_equal(120.00,payment.getHumanizedAmount)
      payment.setAmount(120.3)
      assert_equal(120.30,payment.getHumanizedAmount)
      payment.setAmount(120.21)
      assert_equal(120.21,payment.getHumanizedAmount)
      
      payment.setAmount('12.35')
      assert_equal(12.35,payment.getHumanizedAmount)
      payment.setAmount('12')
      assert_equal(12.00,payment.getHumanizedAmount)
      payment.setAmount('120')
      assert_equal(120.00,payment.getHumanizedAmount)
      payment.setAmount('120.3')
      assert_equal(120.30,payment.getHumanizedAmount)
      payment.setAmount('120.21')
      assert_equal(120.21,payment.getHumanizedAmount)
    end
    def test_verify_acknowledgement
    
      payment = Payment.new
      payment.setKey('h2u282kMks01923kmqpo')
      payment.setMerchantCode('201920191')
      post={'Ds_Amount' => '1235', 'Ds_Order' => '29292929', 'Ds_MerchantCode' => '201920191', 'Ds_Currency' => CURRENCY_EUR, 'Ds_Response' => '0000', 'Ds_Signature' =>'7b62d641e0c523816be3c7f3035a07f88fb1064e'}
      assert(payment.verifyAcknowledge(post))
      post={'Ds_Amount' => '1235', 'Ds_Order' => '29292929', 'Ds_Currency' => CURRENCY_EUR, 'Ds_Response' => '0000', 'Ds_Signature' =>'7b62d641e0c523816be3c7f3035a07f88fb1064e'}
      assert(!payment.verifyAcknowledge(post))
      
      payment.setBankServerResponse('0000')
      assert(payment.isResponsePositive)
      payment.setBankServerResponse('0080')
      assert(payment.isResponsePositive)
      payment.setBankServerResponse('0099')
      assert(payment.isResponsePositive)
      payment.setBankServerResponse('0900')
      assert(payment.isResponsePositive)
      payment.setBankServerResponse('0108')
      assert(!payment.isResponsePositive)
      
    end
end