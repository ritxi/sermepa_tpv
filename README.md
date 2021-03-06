# Configuration

Change **BASE** constant from *php/classes/constants.php* or *ruby/lib/constants.rb* to fit your files location.

**NOTE**: if using Ruby on Rails, BASE is set to RAILS_ROOT

You have to change *config/tpv.yml* with your basic configuration. 

##Available options

*config/tpv.yml* file accepts the following options:

**NOTE**: options on tpv.yml accepts language and currency constants(ex: currency: 'CURRENCY_USD')

###Mandatory

* merchant_code 
* key 

###Optional

* *Property*       -> *Default value*
* currency         ->  CURRENCY_EUR
* terminal         ->  1
* transaction_type ->  0(Authorization) 
* language         ->  LANG_CATALAN
* notification_url ->  ''
* KO_url           ->  ''
* OK_url           ->  ''
* merchant_name    ->  ''

###Available constants

####Currency constants

* CURRENCY_EUR -> Euro 
* CURRENCY_USD -> Dolar US 
* CURRENCY_GBP -> British Pound 
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

#PHP
    development:
      ...
      notification_url: 'http://mywebsite.com/payment_notification.php'
    
    production:
      ...
      notification_url: 'http://mywebsite.com/payment_notification.php'

*payment_notification.php* file has only few lines on how to implement it and what functions might be useful.

#Ruby sinatra

    development:
      ...
      notification_url: 'http://elmeullocweb.com/response'

    production:
      ...
      notification_url: 'http://elmeullocweb.com/response'

Just like php example, but in sample.rb on the "post '/response' do" there's an explanation on how to implement automatic payment verification.

#Setting your TPV to production mode

##PHP

If you want to set your tpv app to production uncomment **define('MODE','production');** at the beginning of *prova.php* and *payment_notification.php*.
    <?
    //define('MODE','production');
    include('classes/payment.php');
    ...
    ?>

##Ruby

When running in Rails it will take RAILS_ENV constant. Otherwise TPV_MODE = 'production' must be set before loading *payment.rb*.

# Executing tests

##PHP
*Simpletest* library 1.0.1 is needed for php version. It can be downloaded from [SimpleTest Website](http://simpletest.org)

Unpack simpletest into **/tests** folder and then execute */tests/payment_test.php* from your webbrowser

##Ruby

Just run payment_test.rb from textmate(**cmd+R**) or run manually "**ruby payment_test.rb**"
