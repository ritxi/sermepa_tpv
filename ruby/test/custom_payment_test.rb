module TPV
  module Base
    module Modes
      CURRENT = 'test'
    end
  end
end
require 'rubygems'
require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/custom_payment"
require "#{File.dirname(__FILE__)}/../lib/ruby_utils"
class TestOfPayment < Test::Unit::TestCase
  include TPV::Bbva
  def test_hidden_helper
    helpers = CustomPaymentHelpers.new
    haml = helpers.haml.capture_haml do
      helpers.hidden_field('test_field','value')
    end
    
    assert_equal("<input id='test_field' name='test_field' type='hidden' value='value' />\n", haml)
  end
  def test_text_helper
    helpers = CustomPaymentHelpers.new
    haml = helpers.haml.capture_haml do
      helpers.text_field('test_field','value')
    end
    
    assert_equal("<input id='test_field' name='test_field' type='text' value='value' />\n", haml)
  end
  def test_select_helper
    helpers = CustomPaymentHelpers.new
    values = {:prova => 'hola'}
    haml = helpers.haml.capture_haml do
      helpers.select_field('test_field',values)
    end
    
    assert_equal(<<HTML, haml)
<select id='test_field' name='test_field'>
  <option value='hola'>
    prova
  </option>
</select>
HTML
  end
  def test_select_helper
    helpers = CustomPaymentHelpers.new
    values = {:prova => 'hola'}
    haml = helpers.haml.capture_haml do
      helpers.date_fields({:model => 'payment', :name => 'expire'},:year=>'2010')
    end

    assert_equal(<<HTML, haml)
<select id='payment_expire_year' name="payment['expire_year']">
  <option value='2010'>
    2010
  </option>
  <option value='2011'>
    2011
  </option>
  <option value='2012'>
    2012
  </option>
  <option value='2013'>
    2013
  </option>
  <option value='2014'>
    2014
  </option>
  <option value='2015'>
    2015
  </option>
  <option value='2016'>
    2016
  </option>
  <option value='2017'>
    2017
  </option>
</select>
<select id='payment_expire_month' name="payment['expire_month']">
  <option value='1'>
    1
  </option>
  <option value='2'>
    2
  </option>
  <option value='3'>
    3
  </option>
  <option value='4'>
    4
  </option>
  <option value='5'>
    5
  </option>
  <option value='6'>
    6
  </option>
  <option value='7'>
    7
  </option>
  <option value='8'>
    8
  </option>
  <option value='9'>
    9
  </option>
  <option value='10'>
    10
  </option>
  <option value='11'>
    11
  </option>
  <option value='12'>
    12
  </option>
</select>
HTML
  end

  def test_formated_amount
    payment = CustomPayment.new(12.35)
    assert_equal(12.35,payment.formated_amount)
    payment.amount=12
    assert_equal(12.00,payment.formated_amount)
    payment.amount=120
    assert_equal(120.00,payment.formated_amount)
    payment.amount=120.3
    assert_equal(120.30,payment.formated_amount)
    payment.amount=120.21
    assert_equal(120.21,payment.formated_amount)
    
    payment.amount='12.35'
    assert_equal(12.35,payment.formated_amount)
    payment.amount='12'
    assert_equal(12.00,payment.formated_amount)
    payment.amount='120'
    assert_equal(120.00,payment.formated_amount)
    payment.amount='120.3'
    assert_equal(120.30,payment.formated_amount)
    payment.amount='120.21'
    assert_equal(120.21,payment.formated_amount)
  end
  def test_signature
    payment = CustomPayment.new(1235,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal("06;0B;03;0D;0C;0F;0E;0E;73;73;03;03;77;05;02;06;06;1A;1F;6E", payment.dark_key)
    assert_equal("12345678", payment.keycode)
    assert_equal("B06666666600001", payment.merchant_code)
    assert_equal("12345678B06666666***", payment.generate_shine_key)
    assert_equal("790999961C55A340005D", payment.deofuscate_key)
    
    # Receiving fake signature on a valid operation response
    fields_for_invalid_signature = {
      'idterminal' =>'631002',
      'idcomercio' =>'B06666666600001',
      'idtransaccion' => '00312023301',
      'importe' => '12,4',
      'moneda' => Currencies::EUR,
      'estado' => '2',
      'coderror' => '000',
      'codautorizacion' => '000065',
      'firma' => 'lkajdsflkñajsdflñajdf'
    }
    validation = PaymentValidation.new(fields_for_invalid_signature,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert(!validation.send(:validate_bank_response_signature))
    

  end
  def test_Receiving_valid_signature_on_a_valid_operation_response
    # Receiving valid signature on a valid operation response
    fields_for_valid_operation = {
      'idterminal' =>'631002',
      'idcomercio' =>'B06666666600001',
      'idtransaccion' => '00312023301',
      'importe' => '12,4',
      'moneda' => Currencies::EUR,
      'estado' => '2',
      'coderror' => '000',
      'codautorizacion' => '000065',
      'firma' => 'lkajdsflkñajsdflñajdf'
    }
    fields_for_valid_operation['firma'] = '8359B01544BB26AE0ABEAB45A9F931D9CDE16198'
    validation = PaymentValidation.new(fields_for_valid_operation,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::VALID, validation.validate_response[:response]) 
  end

  def test_Receiving_a_fake_response
    # Receiving a fake response
    fields_for_fake_operation = {
      'idterminal' =>'631002',
      'idcomercio' =>'B06666666600001',
      'idtransaccion' => '00312023301',
      'importe' => '12,4',
      'moneda' => Currencies::EUR,
      'estado' => '2',
      'coderror' => '000',
      'codautorizacion' => '000065',
      'firma' => 'lkajdsflkñajsdflñajdf'
    }
    fields_for_fake_operation['estado'] = Statuses::DENIED
    fields_for_fake_operation['firma'] = '8359B01545BB26GE0ABEAB45A9F931D9CDE16198'
    validation = PaymentValidation.new(fields_for_fake_operation,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::FAKE, validation.validate_response[:response])
    
    fields_for_fake_response = {}
    validation = PaymentValidation.new(fields_for_fake_response,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::FAKE, validation.validate_response[:response])
  end
  def test_Receiving_a_rejected_response
    # Receiving a rejected response
    fields_for_rejected_operation = {
      'idterminal' =>'631002',
      'idcomercio' =>'B06666666600001',
      'idtransaccion' => '00312023301',
      'importe' => '12,4',
      'moneda' => Currencies::EUR,
      'estado' => '',
      'coderror' => '000',
      'codautorizacion' => '000065',
      'firma' => 'lkajdsflkñajsdflñajdf'
    }
    fields_for_rejected_operation['estado'] = (Statuses::DENIED).to_s
    fields_for_rejected_operation['firma'] = '2C08FC54AA522B64C1C86089F32400BBB07AC4D0'
    validation = PaymentValidation.new(fields_for_rejected_operation,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::REJECTED, validation.validate_response[:response])
  end
  def test_Receiving_a_unformated_response
    # Receiving a unformated response
    fields_for_unformated_operation = {
      'idterminal' =>'631002',
      'idcomercio' =>'B06666666600001',
      'idtransaccion' => '00312023301',
      'importe' => '12,4',
      'moneda' => Currencies::EUR,
      'estado' => '2',
      'coderror' => '000',
      'codautorizacion' => '000065',
      'firma' => 'lkajdsflkñajsdflñajdf'
    }
    fields_for_unformated_operation.delete('estado')
    fields_for_unformated_operation['firma'] = '8569FA4C6DB03039A269F5E006392E15C31FF2A5'
    validation = PaymentValidation.new(fields_for_unformated_operation,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::UNFORMATED, validation.validate_response[:response])
  end
=begin
    #assert(validation.validate_signature)
    #payment.setMerchantCode('201920191')
    #payment.setNotificationUrl('http://www.test.cat')
    #$resultat = 'b7571e2de2c2d0b7a8064f5fa620ef4426a01352'
    #$cadena = TPV::Crypt.sha1('123500292929292019201919780http://www.test.cath2u282kMks01923kmqpo')
    #assert_equal(payment.getSignature,$resultat)
    #assert_equal($cadena,$resultat)
  end
=end
end