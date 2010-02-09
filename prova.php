<?
  include('classes/payment.php');
  $payment = new Payment(400, 'Inscripcio');
  $options = $payment->getOptions();
?>
<html>
  <head>
    <title>Test Pagament</title>
  </head>
  <body>
    <? //echo $payment->show_key();?>
    <? echo $payment->form()."\n"; ?>
      <? foreach( $options as $option){ ?>
           <? echo Payment::hidden_field($option)."\n"; ?>
      <? }?>
      <input type='submit' value='Pagar'>
    </form>
  </body>
</html>