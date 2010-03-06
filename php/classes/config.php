<?php

/**
 * Config Reader
 *
 * Provides access to config files stored in:
 *
 * AK_APP_DIR/config/*.yml
 *
 * = Structure of a config file
 *
 * A config file contains configuration directives for all
 * configured environments (development,testing,production).
 *
 * A config file can have a default configuration section, which will
 * be the base for all other environments. That means if a default configuration
 * directive is not overwritten in an environment, the default directive is active.
 *
 * Example:
 *
 * <code>
 * default:
 *          log:
 *              file:   /tmp/debug.log
 *              level:  verbose
 *
 * development:
 *          log:
 *              file:   /tmp/development.log
 *
 * testing:
 *          log:
 *              file:   /tmp/testing.log
 *
 * production:
 *          log:
 *              file:   /tmp/production.log
 *              level:  error
 * </code>
 *
 * The above example sets a log level of "verbose" as the default.
 * The default log file is in "/tmp/debug.log".
 *
 * The environments development and testing overwrite the default log file.
 *
 * The production environment overwrites as well the log file and the log level.
 *
 * The Log level for development will be "verbose" (inherited from default).
 * The log level for testing will be "verbose" (inherited from default).
 * The log level for production will be "error" (overwritten the default level).
 *
 *
 * = Accessing configuration files
 *
 * The format of the config files is YAML.
 * The convention is that a yaml file in:
 *
 * AK_APP_DIR/config/myconfig.yml
 *
 * can be accessed via:
 *
 *      $config = new AkConfig();
 *      $config->get('myconfig'); // loads myconfig.yml and section "TPV_MODE"
 *
 * By default the configuration for the environment defined in TPV_MODE will be loaded.
 *
 * By providing the desired environment in the get call you can change that:
 *
 *      $config = new AkConfig();
 *      $config->get('myconfig','production'); // loads myconfig.yml and section production
 *
 * = Config caching
 *
 * The AkConfig class caches php representations of the yaml files inside:
 *
 *      TMP_DIR/ak_config/cache/$environment/$config.yml
 *
 * As soon as the modification time of a yaml-config file changes, the cache is invalidated
 * and will be regenerated.
 */
include_once('ak.php');
class AkConfig
{
    const TPV_CONFIG_DIR = TPV_CONFIG_DIR;
    public $options = array(
    'skip_cache' => false
    );

    public function __construct($options = array()){
        if(!empty($options)){
            $this->options = array_merge($this->options, $options);
        }
    }

    public function &get($namespace, $environment = TPV_MODE, $raise_error_if_config_file_not_found = true) {
        $key = $this->_getCacheKey($namespace,$environment);
        if(empty($this->options['skip_cache']) && ($config = Ak::getStaticVar($key))){
            return $config;
        }
        if (!($config = $this->readCache($namespace, $environment))) {
            $config = $this->readConfig($namespace, $environment, $raise_error_if_config_file_not_found);
        }
        if (!isset($_configs[$namespace])) {
            $_configs[$namespace] = array($environment=>$config);
        } else {
            $_configs[$namespace][$environment] = $config;
        }
        Ak::setStaticVar($key, $_configs[$namespace][$environment]);
        return $_configs[$namespace][$environment];
    }

    static function getConstant($name) {
        return defined($name[1]) ? constant($name[1]) : '';
    }

    static function getDir($type, $_set_value = false, $fail_if_not_found = true) {
        static $dir_names = array();
        if($_set_value){
            $dir_names[$type] = $_set_value;
        }
        if(!isset($dir_names[$type])){
            $contstant_name = strtoupper(AkInflector::underscore($type)).'_DIR';
            if(defined($contstant_name)){
                $dir_names[$type] = constant($contstant_name);
            }
        }
        if(!isset($dir_names[$type])){
            if($fail_if_not_found){
                trigger_error('Can\'t find path for directory '.$type.' ', E_USER_ERROR);
            }else{
                return false;
            }
        }
        return $dir_names[$type];
    }

    static function setDir($type, $value) {
        AkConfig::getDir($type, $value, false);
    }

    static function getOption($key, $default = null) {
        $option = Ak::getStaticVar('AkConfig_'.$key);
        if(is_null($option) && !is_null($default)){
            return $default;
        }
        return $option;
    }

    static function rebaseApp($base_path) {
        static $bases = array();

        if($base_path == false){
            if(count($bases) > 1){
                $base = array_shift($bases);
                foreach ($base as $type => $original_path){
                    AkConfig::setDir($type, $original_path);
                }
                return true;
            }
            return false;
        }
        $bases[] =
        array(
        'app'               => AkConfig::getDir('app'),
        'models'            => AkConfig::getDir('models'),
        'app_installers'    => AkConfig::getDir('app_installers'),
        'controllers'       => AkConfig::getDir('controllers'),
        'views'             => AkConfig::getDir('views'),
        'apis'              => AkConfig::getDir('apis'),
        'helpers'           => AkConfig::getDir('helpers'),
        'public'            => AkConfig::getDir('public'),
        );

        AkConfig::setDir('app',             $base_path);
        AkConfig::setDir('app_installers',  $base_path.DS.'installers');
        AkConfig::setDir('models',          $base_path.DS.'models');
        AkConfig::setDir('controllers',     $base_path.DS.'controllers');
        AkConfig::setDir('views',           $base_path.DS.'views');
        AkConfig::setDir('apis',            $base_path.DS.'apis');
        AkConfig::setDir('helpers',         $base_path.DS.'helpers');
        AkConfig::setDir('public',          $base_path.DS.'public');
        return true;
    }

    static function leaveBase() {
        return AkConfig::rebaseApp(false);
    }

    static function setOption($key, $value) {
        Ak::setStaticVar('AkConfig_'.$key, $value);
        return $value;
    }

    static function getLocalesReady() {
        Ak::t('Akelos');
        TPV_ENABLE_PROFILER &&  Ak::profile('Got multilingual ');
    }

    static function parseSettingsConstants($settingsStr) {
        return preg_replace_callback('/\$\{(TPV_.*?)\}/',array('AkConfig','getConstant'),$settingsStr);
    }

    public function readConfig($namespace, $environment = TPV_MODE, $raise_error_if_config_file_not_found = true) {
        $yaml_file_name = $this->_generateConfigFileName($namespace);
        if (!file_exists($yaml_file_name)){
            if($raise_error_if_config_file_not_found){
                trigger_error("Could not find $namespace settings file in $yaml_file_name.\n", E_USER_ERROR);
            }
            return false;
        }
        return $this->readConfigYaml($namespace, file_get_contents($yaml_file_name), $environment);
    }

    public function readConfigYaml($namespace, $yaml_string, $environment = TPV_MODE){
        require_once('spyc.php');
        $content = self::parseSettingsConstants($yaml_string);
        $config = Spyc::YAMLLoad($content);
        return $this->readConfigArray($namespace, $config, $environment);
    }

    public function readConfigArray($namespace, $config = array(), $environment = TPV_MODE){
        if (!is_array($config)){
            return false;
        }
        $default = isset($config['default']) ? $config['default'] : array();
        $configs = array();
        unset($config['default']);
        $environments = array_keys($config);
        $default_environments = Ak::toArray(TPV_AVAILABLE_MODES);
        $environments = array_merge($default_environments, $environments);
        foreach($environments as $env) {
            $envConfig = $this->_merge($default, isset($config[$env]) ? $config[$env] : array());
            $this->writeCache($envConfig, $namespace, $env, $this->_useWriteCache($environment));
            $configs[$env] = $envConfig;
        }

        return isset($configs[$environment]) ? $configs[$environment] : (in_array($environments, $environments) ? $default : false);
    }

    static function getCacheFileName($namespace, $environment = TPV_MODE) {
        return AkConfig::getCacheBasePath($environment).DS.'ak_config'.DS.'cache'.DS.$environment.DS.Ak::sanitize_include($namespace, 'high').'.php';
    }

    static function getCacheBasePath() {
        return TMP_DIR;
    }

    public function readCache($namespace, $environment = TPV_MODE, $force = false) {
        if ((!$force && !$this->_useReadCache($environment))){
            return false;
        }
        $cacheFileName = $this->getCacheFileName($namespace,$environment);
        if (!$this->_configNeedsToBeCached($namespace, $environment)) {
            $config = include $cacheFileName;
        } else {
            $config = false;
        }
        return $config;
    }

    public function writeCache($config, $namespace, $environment = TPV_MODE, $force = false) {
        if (!$force && !$this->_useWriteCache($environment)){
            return false;
        }

        $key = $this->_getCacheKey($namespace,$environment);
        Ak::setStaticVar($key, $config);

        $var_export = var_export($config, true);
        $cache = <<<CACHE
<?php
/**
 * Auto-generated config cache from $namespace in environment $environment
 */
\$config = $var_export;
return \$config;

CACHE;
        $cache_file_name = $this->getCacheFileName($namespace, $environment);

        if(!Ak::file_put_contents($cache_file_name, $cache, array('base_path' => AkConfig::getCacheBasePath()))){
            trigger_error(Ak::t('Could not create config cache file %file', array('%file'=>$cache_file_name)).' '.Ak::getFileAndNumberTextForError(1), E_USER_ERROR);
            return false;
        }else{
            return true;
        }
    }

    public function clearStaticCache($namespace, $environment = TPV_MODE){
        $key = $this->_getCacheKey($namespace,$environment);
        Ak::unsetStaticVar($key);
    }

    static function getErrorReportingLevelDescription($error_reporting_level = null) {
        if(is_null($error_reporting_level)){
            $error_reporting_level = error_reporting();
        }
        $_constants = get_defined_constants(true);
        $internal_constants = !empty($_constants['internal']) ? $_constants['internal'] : (array)@$_constants['mhash'];
        unset($_constants);

        $result = array();
        if(($error_reporting_level & E_ALL) == E_ALL){
            $result[] = 'E_ALL';
            $error_reporting_level &=~ E_ALL;
        }
        foreach($internal_constants as $error_reporting_level_name => $constant){
            if(preg_match('/^E_/', $error_reporting_level_name)){
                if(($error_reporting_level & $constant) == $constant){
                    $result[] = $error_reporting_level_name;
                }
            }
        }
        return join(' | ',$result);
    }

    protected function _useReadCache($environment = TPV_MODE) {
        if(TPV_CLI && TPV_MODE != 'testing'){
            return false;
        }
        return ($environment == 'production' || $environment == 'setup');
    }

    protected function _useWriteCache($environment = TPV_MODE) {
        if(TPV_CLI && TPV_MODE != 'testing'){
            return false;
        }
        return $environment != 'setup';
    }

    protected function _configNeedsToBeCached($namespace,$environment) {
        $cache_file = $this->getCacheFileName($namespace,$environment);
        $config_file = $this->_generateConfigFileName($namespace);
        return (@filemtime($config_file) > @filemtime($cache_file)) || !file_exists($config_file);
    }

    protected function _generateConfigFileName($namespace) {
        $namespace = Ak::sanitize_include($namespace, 'high');
        $yaml_file_name = self::TPV_CONFIG_DIR.DS.$namespace.'.yml';
        return $yaml_file_name;
    }

    protected function _merge($default,$env) {
        if (is_array($default)) {
            foreach($default as $key => $value) {
                if (!is_array($value)) {
                    $env[$key] = isset($env[$key]) ? $env[$key] : $value;
                } else {
                    $env[$key] = $this->_merge($value, isset($env[$key])?$env[$key] : array());
                }
            }
        } else {
            $env = empty($env) ? $default : $env;
        }
        return $env;
    }

    protected function _getCacheKey($namespace, $environment){
        return '_config_'.$namespace.$environment.TPV_WEB_REQUEST;
    }
}

?>