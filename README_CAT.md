# Configuració

Canviar la constant **BASE** de *php/classes/constants.php* o *ruby/lib/constants.rb* perquè s'adapti al lloc on es trobin els teus fitxers.

ATENCIO: si empres Ruby on Rails, BASE s'inicialitzarà a RAILS_ROOT

Cal canviar *config/tpv.yml* amb la teva configuració bàsica.

##Opcions disponibles

El fitxer *config/tpv.yml* accepta les següents opcions:

###Obligatori

* merchant_code 
* key 

###Opcional

* *Propietat*       -> *Valor per defecte*
* currency         ->  CURRENCY_EUR
* terminal         ->  1
* transaction_type ->  0(Authorization) 
* language         ->  LANG_CATALAN
* notification_url ->  ''
* KO_url           ->  ''
* OK_url           ->  ''
* merchant_name    ->  ''

###Constants disponibles

####Constants de divisa

* CURRENCY_EUR -> Euro 
* CURRENCY_USD -> Dolar US 
* CURRENCY_GBP -> British Pound 
* CURRENCY_YEN -> Japanese Yen 

####Constants de llengua

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

#Emprant notification_url

Per emprar aquesta opció cal activar la notificació **HTTP Form** del panell de control de sermepa.

Afegir **notification_url** a *config/tpv.yml*

#PHP

    development:
      ...
      notification_url: 'http://elmeullocweb.com/payment_notification.php'
    
    production:
      ...
      notification_url: 'http://elmeullocweb.com/payment_notification.php'

El fitxer *payment_notification.php* només té unes quantes linies sobre com implementar la notificació i quines funcions poden ser útils.

#Ruby sinatra

    development:
      ...
      notification_url: 'http://elmeullocweb.com/response'

    production:
      ...
      notification_url: 'http://elmeullocweb.com/response'

Igual que a l'exemple amb php, en el sample.rb a "post '/response' do" hi ha explicat com implementar la verificació automàtica d'un pagament.

#Posant el TPV en mode producció

##PHP

Si vols posar el tpv en mode producció descomenta **define('MODE','production');** a l'inici de *prova.php* i *payment_notification.php*.

    <?
    //define('MODE','production');
    include('classes/payment.php');
    ...
    ?>

##Ruby
Quan executem amb Rails agafarà la constant RAILS_ENV. En altres casos cal especificar TPV_MODE = 'production' abans de carregar *payment.rb*.

#Executant els tests

##PHP
Cal la llibreria *Simpletest* 1.0.1 per PHP que pot ser descarregada del [http://simpletest.org](Web de SimpleTest)

Descomprimeix simpletest dins la carpeta **/tests** i llavors executa */tests/payment_test.php* des del teu navegador.

##Ruby

Simplement executa payment_test.rb des del textmate(cmd+R) o manualment des del terminal fer "ruby payment_test.rb"
