module TPV
  module Base
    module Modes
      CURRENT = 'test'
    end
  end
end
require 'rubygems'
require "test/unit"
%w(custom_payment ruby_utils).each{|file|  require File.join(File.dirname(__FILE__),'..','lib',file)}

class TestOfPayment < Test::Unit::TestCase
  include TPV::Bbva
  def setup
    
  end
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
    fields_for_invalid_signature = bank_response({'estado' => Statuses::ACCEPTED})
    validation = PaymentValidation.new(fields_for_invalid_signature,{:load_config => {:file => 'tpv.bbva.yml'}})
    # Expected signature base string before sha1 operation
    assert_equal("631002B066666666000010031202330112409782000000065#{validation.send(:deofuscate_key)}", validation.send(:signature_string_base))
    assert(!validation.send(:validate_bank_response_signature))
  end

  def test_Receiving_valid_signature_on_a_valid_operation_response
    # Receiving valid signature on a valid operation response
    fields_for_valid_operation = bank_response({'estado' => Statuses::ACCEPTED, 'firma' => '8359B01544BB26AE0ABEAB45A9F931D9CDE16198'})
    validation = PaymentValidation.new(fields_for_valid_operation,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal('8359B01544BB26AE0ABEAB45A9F931D9CDE16198', validation.send(:calculate_bank_signature))
    assert_equal(Responses::VALID, validation.validate_response[:response])
  end


  def test_Receiving_a_fake_response
    # Receiving a fake response
    fields_for_fake_operation =  bank_response({'estado' => Statuses::DENIED,   'firma' => '8359B01545BB26GE0ABEAB45A9F931D9CDE16198'})
    validation = PaymentValidation.new(fields_for_fake_operation,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::FAKE, validation.validate_response[:response])
    
    fields_for_fake_response = ""
    validation = PaymentValidation.new(fields_for_fake_response,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::FAKE, validation.validate_response[:response])
  end
  def test_Receiving_a_rejected_response
    # Receiving a rejected response
    fields_for_rejected_operation = bank_response({'estado' => Statuses::DENIED, 'firma' => '2C08FC54AA522B64C1C86089F32400BBB07AC4D0'})
    validation = PaymentValidation.new(fields_for_rejected_operation,{:load_config => {:file => 'tpv.bbva.yml'}}) 
    assert_equal('2C08FC54AA522B64C1C86089F32400BBB07AC4D0', validation.send(:calculate_bank_signature))
    assert_equal(Responses::REJECTED, validation.validate_response[:response])
  end
  def test_Receiving_a_unformated_response
    # Receiving a unformated response
    fields_for_unformated_operation = bank_response({'firma' => '8569FA4C6DB03039A269F5E006392E15C31FF2A5'})
    validation = PaymentValidation.new(fields_for_unformated_operation,{:load_config => {:file => 'tpv.bbva.yml'}})
    assert_equal(Responses::UNFORMATED, validation.validate_response[:response])
  end

  def bank_response(options={})
    options = {'firma' => 'lkajdsflkñajsdflñajdf', 'date' => '09/09/2002 23:09:00'}.merge(options)

    text = File.get_content(File.join(File.dirname(__FILE__),'fixtures','xml','tpv_respago.xml.haml'))
    obj = Object.new
    Haml::Engine.new(text).def_method(obj, :render, :options)
    obj.render(:options => options)
  end
end