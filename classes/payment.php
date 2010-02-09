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
  private $merchant_url = '';
  private $key = '';
  private $language = LANG_CATALAN;
  private $notification_url = '';
  private $KO_url = '';
  private $OK_url = '';
  private $merchant_name = '';
  
  //Loaded configuration
  private $config = '';
  private $unknown_properties = '';

  function __construct($amount, $description, $order_id=''){
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
    return array('currency' , 'terminal' , 'transaction_type', 'merchant_code' , 'merchant_url' , 'key' , 'language' , 'notification_url', 'KO_url' , 'OK_url' , 'merchant_name');
  }
  function setAmount($value){
    is_string($value) && $value = 1.00 * $value;
    $this->amount = $value * 100;
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
      $this->signature = sha1($this->amount.$this->getOrderId().$this->merchant_code.$this->currency.$this->transaction_type.$this->getMerchantUrl().$this->key);
    }
    return $this->signature;
  }
  function setMerchantUrl($value){
    !preg_match('/^(http|https)\:\/\/(.*)/', $value) && $value = "http://$value";
    
    $this->merchant_url = $value;
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
  function setNotificationUrl($value){
    $this->notification_url = $value;
  }
  function setMerchantName($value){
    $this->merchant_name = $value;
  }
  function setLanguage($value){
    $this->language = $value;
  }
  
  function getMerchantUrl(){
    return $this->merchant_url;
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
      array('value' => $this->language,         'key' => 'Ds_Merchant_ConsumerLanguage'),
      array('value' => $this->merchant_url,     'key' => 'Ds_Merchant_MerchantURL')
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
  function getDescription(){
    return $this->description;
  }
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