# Configuration

Change **BASE** constant from *classes/constants.php* to fit your files location.

You have to change *config/tpv.yml* with your basic configuration. 

##Available options

*config/tpv.yml* file accepts the following options:

###Mandatory

* merchant_code 
* key 

###Optional

* *Property*  -> *Default value*
* currency          -> CURRENCY_EUR
* terminal          -> 1
* transaction_type  -> 0(Authorization) 
* language          -> LANG_CATALAN
* notification_url  -> ''
* KO_url            -> ''
* OK_url            -> ''
* merchant_name     -> ''

###Available constants

####Currency constants

* CURRENCY_EUR -> Euro 
* CURRENCY_USD -> Dolar US 
* CURRENCY_PUK -> British Pound 
* CURRENCY_YEN -> Japanese Yen 

####Language constants

* LANG_CASTILIAN 
* LANG_ENGLISH 
* LANG_CATALAN 
* LANG_FRENCH 
* LANG_GERMAN 
* LANG_DUTCH 
* LANG_ITALIAN 
* LANG_SWEDISH 
* LANG_PORTUGUESE 
* LANG_POLISH 
* LANG_GALICIAN 
* LANG_BASQUE 

#Using notification_url

To use this option you must activate **HTTP Form** notification on your sermepa control panel.

Add **notification_url** to *config/tpv.yml*

    development:
      ...
      notification_url: 'http://mywebsite.com/payment_notification.php'
    
    production:
      ...
      notification_url: 'http://mywebsite.com/payment_notification.php'

*payment_notification.php* file has only few lines on how to implement it and what functions might be useful.

#Setting your TPV to production mode

If you want to set your tpv app to production uncomment **define('MODE','production');** at the beginning of *prova.php* and *payment_notification.php*.
    <?
    //define('MODE','production');
    include('classes/payment.php');
    ...
    ?>

# Executing tests

*Simpletest* library 1.0.1 is needed. It can be downloaded from [http://simpletest.org](SimpleTest Website)

Unpack simpletest into **/tests** folder and then execute */tests/payment_test.php* from your webbrowser
