<?
defined('BASE')                || define('BASE', '/Users/ricard/develop/ues_tpv');
defined('DS')                  || define('DS', '/');
defined('TMP_DIR')             || define('TMP_DIR',BASE.DS.'tmp');
defined('TPV_CONFIG_DIR')      || define('TPV_CONFIG_DIR',BASE.DS.'config');
defined('TPV_AVAILABLE_MODES') || define('TPV_AVAILABLE_MODES','setup,testing,development,production,staging');
defined('TPV_CLI')             || define('TPV_CLI', php_sapi_name() == 'cli');
defined('TPV_WEB_REQUEST')     || define('TPV_WEB_REQUEST', !empty($_SERVER['REQUEST_URI']));
defined('TPV_CAN_FORK')        || define('TPV_CAN_FORK', function_exists('pcntl_fork'));
defined('TPV_MODE')            || define('TPV_MODE', 'development');
defined('TPV_DEV_MODE')        || define('TPV_DEV_MODE',        TPV_MODE == 'development');
defined('TPV_TEST_MODE')       || define('TPV_TEST_MODE',       TPV_MODE == 'testing');
defined('TPV_STAGING_MODE')    || define('TPV_STAGING_MODE',    TPV_MODE == 'staging');
defined('TPV_PRODUCTION_MODE') || define('TPV_PRODUCTION_MODE', TPV_MODE == 'production');
defined('TPV_ENABLE_PROFILER') || define('TPV_ENABLE_PROFILER', false);
defined('TPV_WIN')             || define('TPV_WIN', strtoupper(substr(PHP_OS, 0, 3)) === 'WIN');
defined('TPV_OS')              || define('TPV_OS', TPV_WIN ? 'WINDOWS' : 'UNIX');

define('LANG_CASTILIAN',  '001');
define('LANG_ENGLISH',    '002');
define('LANG_CATALAN',    '003');
define('LANG_FRENCH',     '004');
define('LANG_GERMAN',     '005');
define('LANG_DUTCH',      '006');
define('LANG_ITALIAN',    '007');
define('LANG_SWEDISH',    '008');
define('LANG_PORTUGUESE', '009');
define('LANG_POLISH',     '011');
define('LANG_GALICIAN',   '012');
define('LANG_BASQUE',     '013');

define('CURRENCY_EUR',    978); //EURO
define('CURRENCY_USD',    840); //Dolar US
define('CURRENCY_PUK',    826); //British Pound
define('CURRENCY_YEN',    392); //Japanese Yen
?>