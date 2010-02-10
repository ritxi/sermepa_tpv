<?
function_exists('sha1') || require_once 'crypt.php'; //Add sha1 encryption function for Php4
//define('TPV_MODE','development');

include_once('constants.php');
require_once('config.php');

class Payment{
  //Payment properties
  private $amount = '';
  private $description = '';
  private $currency = CURRENCY_EUR;
  private $terminal = 1;
  private $transaction_type = 0;
  private $signature = '';
  private $merchant_code = '';
  private $key = '';
  private $language = LANG_CATALAN;
  private $notification_url = '';
  private $KO_url = '';
  private $OK_url = '';
  private $merchant_name = '';
  
  //Loaded configuration
  private $config = '';
  private $unknown_properties = '';
  
  //This variable is set after verifing Acknowledge message
  private $bank_server_response = '';

  function __construct($amount='', $description='', $order_id=''){
    $this->load_config();
    $this->setAmount($amount);
    $this->description = $description;
    $this->order_id = $this->getOrderId($order_id);
    if(TPV_PRODUCTION_MODE){
      $this->tpvurl = 'https://sis.sermepa.es/sis/realizarPago';
    }else{
      $this->tpvurl = 'https://sis-t.sermepa.es:25443/sis/realizarPago';
    }
  }
  
  //Available properties to be loaded from config file
  static function getProperties(){
    return array('currency' , 'terminal' , 'transaction_type', 'merchant_code', 'key' , 'language' , 'notification_url', 'KO_url' , 'OK_url' , 'merchant_name');
  }
  //Acknowledge fields that must be received
  static function getAcklogedgeFields(){
    return array('Ds_Amount', 'Ds_Order', 'Ds_MerchantCode', 'Ds_Currency', 'Ds_Response' , 'Ds_Signature');
  }
  //Posible responses from the bank
  static function getCodeResponseMeaning(){
    return array('0-99' => 'Transaction authorised for payments and pre-authorisations'
    ,'0900' => 'Transaction authorised for refunds and confirmations'
    ,'101' => 'Card expired'
    ,'102' =>  'Card temporarily suspended or under suspicion of fraud'
    ,'104' =>  'Transaction not allowed for the card or terminal'
    ,'116' =>  'Insufficient funds'
    ,'118' =>  'Card not registered'
    ,'129' =>  'Security code (CVV2/CVC2) incorrect'
    ,'180' =>  'Card not recognised'
    ,'184' =>  'Cardholder authentication failed'
    ,'190' =>  'Transaction declined without explanation'
    ,'191' =>  'Wrong expiration date'
    ,'202' =>  'Card temporarily suspended or under suspicion of fraud with confiscation order'
    ,'912' =>  'Issuing bank not available'
    ,'9912' =>  'Issuing bank not available'
    ,'else' =>  'Transaction declined');
  }
  //Acknowledgement message functions
  function verifyAcknowledge($post){
    foreach($this->getAcklogedgeFields() as $field){
      if(!array_key_exists($field, $post)){
        return false;
      }
    }
    $this->bank_server_response = $post["Ds_Response"];
    $message = sha1($post["Ds_Amount"].$post["Ds_Order"].$post["Ds_MerchantCode"].$post["Ds_Currency"].$post["Ds_Response"].$this->key);
    $this->amount = $post["Ds_Amount"];
    $this->setOrderId($post["Ds_Order"]);
    $this->setCurrency($post["Ds_Currency"]);
    return $post["Ds_Signature"] == $message;
  }
  function getBankServerResponse(){
    if(empty($this->bank_server_response)){
      return -1;
    }else{
      return $this->bank_server_response;
    }
  }
  function isResponsePositive(){
    // This function return true if Bank response is 0-99 or 0900
    $response = $this->getBankServerResponse()*1;
    return ($response >= 0 && $response <= 99) || $this->getBankServerResponse() == '0900' ?  true : false;
  }
  function setBankServerResponse($code){
    !TPV_TEST_MODE && trigger_error('This function is only for testing purpose',E_USER_ERROR);
    $this->bank_server_response = $code;
  }
  //Options setter functions
  function setNotificationUrl($value){
    !preg_match('/^(http|https)\:\/\/(.*)/', $value) && $value = "http://$value";
    
    $this->notification_url = $value;
  }
  function setAmount($value){
    is_string($value) && $value = 1.00 * $value;
    $this->amount = $value * 100;
  }
  function setMerchantCode($value){
    $this->merchant_code = $value;
  }
  function setKey($value){
    $this->key = $value;
  }
  function setKoUrl($value){
    $this->KO_url = $value;
  }
  function setOkUrl($value){
    $this->OK_url = $value;
  }
  function setMerchantName($value){
    $this->merchant_name = $value;
  }
  function setLanguage($value){
    $this->language = $value;
  }
  function setOrderId($value){
    $this->order_id = $value;
  }
  function setCurrency($value){
    $this->currency = $value;
  }
  //Options getter functions
  function getNotificationUrl(){
    return $this->notification_url;
  }
  function getMustOptions(){
    return array(
      array('value' => $this->amount,           'key' => 'Ds_Merchant_Amount'),
      array('value' => $this->currency,         'key' => 'Ds_Merchant_Currency'),
      array('value' => $this->getOrderId(),     'key' => 'Ds_Merchant_Order'),
      array('value' => $this->description,      'key' => 'Ds_Merchant_ProductDescription'),
      array('value' => $this->merchant_code,    'key' => 'Ds_Merchant_MerchantCode'),
      array('value' => $this->getSignature(),   'key' => 'Ds_Merchant_MerchantSignature'),
      array('value' => $this->terminal,         'key' => 'Ds_Merchant_Terminal'),
      array('value' => $this->transaction_type, 'key' => 'Ds_Merchant_TransactionType'),
      array('value' => $this->language,         'key' => 'Ds_Merchant_ConsumerLanguage')
    );
  }
  function getOptionalOptions(){
    $options = array(
      array('value' => $this->merchant_name,    'key' => 'Ds_Merchant_Titular'),
      array('value' => $this->notification_url, 'key' => 'Ds_Merchant_MerchantURL'),
      array('value' => $this->KO_url,           'key' => 'Ds_Merchant_UrlKO'),
      array('value' => $this->OK_url,           'key' => 'Ds_Merchant_UrlOK')
    );
    $result = array();
    foreach($options as $option){
      if(!empty($option['value'])){
        $result[] = $option;
      }
    }
    return $result;
  }
  function getOptions(){
    return array_merge($this->getMustOptions(),$this->getOptionalOptions());
  }
  function getAmount(){
    return $this->amount;
  }
  function getHumanizedAmount(){
    return $this->getAmount() / 100.00;
  }
  function getDescription(){
    return $this->description;
  }
  function getOrderId($order_id=''){
    if(empty($this->order_id)){
      if(empty($order_id)){
        $this->order_id = date('ymdHis');
      }else{
        $this->order_id = $order_id;
      }
    }
    return $this->order_id;
  }
  function getSignature(){
    if(empty($this->signature)){
      //Ds_Merchant_Amount + Ds_Merchant_Order +Ds_Merchant_MerchantCode + DS_Merchant_Currency +Ds_Merchant_TransactionType +	Ds_Merchant_MerchantURL + CLAVE SECRETA
      $this->signature = sha1($this->amount.$this->getOrderId().$this->merchant_code.$this->currency.$this->transaction_type.$this->getNotificationUrl().$this->key);
    }
    return $this->signature;
  }
  function getCurrency($value){
    return $this->currency;
  }
  //Form helpers
  static function hidden_field($array){
    $key = $array['key'];
    $value = $array['value'];
    return "<input type='hidden' value='$value' name='$key' id='$key' />";
  }
  function form(){
    return '<form action="'.$this->tpvurl.'" method="post" target="tpv">';
  }
  
  private function load_config(){
    if(empty($this->config)){
      $config = new AkConfig();
      $this->config = $config->get('tpv',TPV_MODE);
      $unknown_properties = array();
      foreach($this->config as $conf => $value){
        if(in_array($conf,Payment::getProperties())){
          ($conf=='language' || $conf=='currency') && !is_numeric($value) && $value=constant($value);
          $this->$conf = $value;
        }else{
          $this->unknown_properties[] = $conf;
        }
      }
    }
    is_array($this->unknown_properties) && $this->unknown_properties = count($this->unknown_properties);
    return $this->unknown_properties;
  }
}
?>