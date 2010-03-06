
defined?( BASE               ) || (defined?(RAILS_ROOT) && BASE = RAILS_ROOT) || BASE = '/Users/ricard/develop/sermepa_tpv'
defined?( DS                 ) || DS = '/'
defined?( TMP_DIR            ) || TMP_DIR = BASE+DS+'tmp'
defined?( TPV_CONFIG_DIR     ) || TPV_CONFIG_DIR = BASE+DS+'config'
defined?( TPV_AVAILABLE_MODES) || TPV_AVAILABLE_MODES = %w(setup testing development production staging)
#defined(? TPV_WEB_REQUEST   )  || TPV_WEB_REQUEST', !empty($_SERVER['REQUEST_URI'])
#efined?( TPV_CAN_FORK       ) || TPV_CAN_FORK', function_exists('pcntl_fork')
defined?( TPV_MODE           ) || (defined?(RAILS_ENV) && TPV_MODE = RAILS_ENV) || TPV_MODE = 'development'
defined?( TPV_DEV_MODE       ) || TPV_DEV_MODE =        TPV_MODE == 'development'
defined?( TPV_TEST_MODE      ) || TPV_TEST_MODE =       TPV_MODE == 'testing'
defined?( TPV_STAGING_MODE   ) || TPV_STAGING_MODE =    TPV_MODE == 'staging'
defined?( TPV_PRODUCTION_MODE) || TPV_PRODUCTION_MODE = TPV_MODE == 'production'
#defined? TPV_ENABLE_PROFILER || TPV_ENABLE_PROFILER', false);
#defined? TPV_WIN             || TPV_WIN', strtoupper(substr(PHP_OS, 0, 3)) === 'WIN');
#defined? TPV_OS              || TPV_OS', TPV_WIN ? 'WINDOWS' : 'UNIX');




LANG_CASTILIAN  = '001'
LANG_ENGLISH    = '002'
LANG_CATALAN    = '003'
LANG_FRENCH     = '004'
LANG_GERMAN     = '005'
LANG_DUTCH      = '006'
LANG_ITALIAN    = '007'
LANG_SWEDISH    = '008'
LANG_PORTUGUESE = '009'
LANG_POLISH     = '011'
LANG_GALICIAN   = '012'
LANG_BASQUE     = '013'

CURRENCY_EUR    = 978 #EURO
CURRENCY_USD    = 840 #Dolar US
CURRENCY_GBP    = 826 #British Pound
CURRENCY_YEN    = 392 #Japanese Yen
