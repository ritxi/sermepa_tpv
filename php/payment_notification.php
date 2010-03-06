<?
  /* This file will receive bank responses after every transaction,
     after verifing the information received is valid, then you should
     verify that is positive so you can update your database and set 
     transaction as complete.
  */
  //define('MODE','production'); //Uncomment when the app is ready for production
  include('classes/payment.php');
  $payment = new Payment();
  if($payment->verifyAcknowledge($_POST)){
    if($payment->isResponsePositive()){
      // Find $this->getOrderId() and
      // mark your transaction as complete and positive
    }else{
      /* Find $this->getOrderId() and
         mark your transaction as complete and failed.
         You can get a more details version of the error by
         using $this->getBankServerResponse() and Payment::getCodeResponseMeaning() 
       */
    }
  }
?>