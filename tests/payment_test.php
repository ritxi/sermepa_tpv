<?php
require_once('simpletest/autorun.php');
require_once('../classes/payment.php');

class TestOfPayment extends UnitTestCase {
    function testPaymentHasMinimalFields(){
      $payment = new Payment(20,'Inscripcio');
      $id = $payment->getOrderId();
      $this->assertEqual($id,date('ymdHis'));
      $this->assertEqual($payment->getAmount(),2000);
      $this->assertEqual($payment->getDescription(),'Inscripcio');
      $this->assertEqual(count($payment->getOptions()), 10); 
    }
    function testPaymentHasOptionalFields(){
      $payment = new Payment(20,'Inscripcio');
      $this->assertEqual(count($payment->getOptions()), 10); 
      $payment->setMerchantName('Unió Excursionista de Sabadell');
      $this->assertEqual(count($payment->getOptions()), 11); 
      $payment->setNotificationUrl('testing value');
      $this->assertEqual(count($payment->getOptions()), 12);
      $payment->setOkUrl('ok url');
      $this->assertEqual(count($payment->getOptions()), 13);
      $payment->setKoUrl('ko url');
      $this->assertEqual(count($payment->getOptions()), 14);
    }
    function testGetHtmlHiddenField(){
      $payment = new Payment(20,'Inscripcio');
      $expected_field = "<input type='hidden' value='2000' name='Ds_Merchant_Amount' id='Ds_Merchant_Amount' />";
      $options = $payment->getOptions();
      $given_field = Payment::hidden_field($options[0]);
      
      $this->assertEqual($given_field, $expected_field);
    }
    function test_payment_amount(){
      $payment = new Payment(12.35,'Inscripcio','29292929');
      $this->assertEqual('1235',$payment->getAmount());
      $payment->setAmount(12);
      $this->assertEqual('1200',$payment->getAmount());
      $payment->setAmount(120);
      $this->assertEqual('12000',$payment->getAmount());
      $payment->setAmount(120.3);
      $this->assertEqual('12030',$payment->getAmount());
      $payment->setAmount(120.21);
      $this->assertEqual('12021',$payment->getAmount());
      
      $payment->setAmount('12.35');
      $this->assertEqual('1235',$payment->getAmount());
      $payment->setAmount('12');
      $this->assertEqual('1200',$payment->getAmount());
      $payment->setAmount('120');
      $this->assertEqual('12000',$payment->getAmount());
      $payment->setAmount('120.3');
      $this->assertEqual('12030',$payment->getAmount());
      $payment->setAmount('120.21');
      $this->assertEqual('12021',$payment->getAmount());
    }
    function test_set_merchant_url(){
      $payment = new Payment(1235,'Inscripcio','29292929');
      $payment->setMerchantUrl('test.cat');
      $this->assertEqual($payment->getMerchantUrl(),'http://test.cat');
      $payment->setMerchantUrl('http://www.test.cat');
      $this->assertEqual($payment->getMerchantUrl(),'http://www.test.cat');
    }
    function test_signature(){
      $payment = new Payment(1235,'Inscripcio','29292929');
      $payment->setKey('h2u282kMks01923kmqpo');
      $payment->setMerchantCode('201920191');
      $payment->setMerchantUrl('http://www.test.cat');
      $resultat = 'b7571e2de2c2d0b7a8064f5fa620ef4426a01352';
      $cadena = sha1('123500292929292019201919780http://www.test.cath2u282kMks01923kmqpo');
      $this->assertEqual($payment->getSignature(),$resultat);
      $this->assertEqual($cadena,$resultat);
    }
}
?>