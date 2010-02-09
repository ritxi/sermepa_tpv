# Configuration

Change BASE constant from classes/constants.php to fit your files location

You have to change config/tpv.yml with your basic configuration.

This file accepts the following options:

##Mandatory

merchant_code
merchant_url
key

##Optional

currency
terminal
transaction_type
language
notification_url
KO_url
OK_url
merchant_name

###Available constants

####Currency constants

CURRENCY_EUR -> Euro
CURRENCY_USD -> Dolar US
CURRENCY_PUK -> British Pound
CURRENCY_YEN -> Japanese Yen

####Language constants
LANG_CASTILIAN
LANG_ENGLISH  
LANG_CATALAN  
LANG_FRENCH   
LANG_GERMAN   
LANG_DUTCH    
LANG_ITALIAN  
LANG_SWEDISH  
LANG_PORTUGUESE
LANG_POLISH 
LANG_GALICIAN
LANG_BASQUE



# Executing tests

Simpletest library 1.0.1 is needed. It can be downloaded from http://simpletest.org

Then execute /tests/payment_test.php from your webbrowser
