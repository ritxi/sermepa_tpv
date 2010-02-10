<?
/**
* Akelos Framework static functions
*
* Ak contains all the Akelos Framework static functions. This
* class acts like a name space to avoid naming collisions
* when PHP gets new functions into its core. And also to provide
* additional functionality to existing PHP functions mantaining the same interface
*
* This is a lightweight version extracted from Akelos framework
*/
class Ak{
  static function toArray(){
    $args = func_get_args();
    return is_array($args[0]) ? $args[0] : (func_num_args() === 1 ? Ak::stringToArray($args[0]) : $args);
  }
  static function stringToArray($string) {
      $args = $string;
      if(count($args) == 1 && !is_array($args)){
      (array)$args = array_unique(array_map('trim',array_diff(explode(',',strtr($args.',',';|-',',,,')),array(''))));
      }
      return $args;
  }
  static function &unsetStaticVar($name) {
      $null = null;
      $refhack = Ak::_staticVar($name, $null, true);
      return $refhack;
  }
  static function setStaticVar($name,&$value) {
      $refhack = Ak::_staticVar($name,$value);
      return $refhack;
  }
  static function file_put_contents($file_name, $content, $options = array()) {

      $default_options = array(
      
      'base_path' => strstr($file_name, TMP_DIR) ?  TMP_DIR : BASE,
      );
      $options = array_merge($default_options, $options);

      $file_name = trim(str_replace($options['base_path'], '',$file_name),DS);


      $base_path = (TPV_WIN&&empty($options['base_path'])?'':$options['base_path'].DS);
      if(!is_dir(dirname($base_path.$file_name))){
          Ak::make_dir(dirname($base_path.$file_name), $options);
      }

      if(!$result = file_put_contents($base_path.$file_name, $content)){
          if(!empty($content)){
              trigger_error("Could not write to file: $base_path.$file_name. Please change file/dir permissions or enable FTP file handling on your Akelos application.",  E_USER_ERROR);
          }
      }
      return $result;
      
  }
  static function make_dir($path, $options = array()) {

      $default_options = array(
      'base_path' => BASE
      );

      $options = array_merge($default_options, $options);

      if(!is_dir($options['base_path']) && !Ak::make_dir($options['base_path'], array('base_path' => dirname($options['base_path'])))){
          trigger_error('Base path '.$options['base_path'].' must exist in order to use it as base_path in Ak::make_dir()', E_USER_ERROR);
      }

      $path = trim(str_replace($options['base_path'], '',$path),DS);

      $base_path = (TPV_WIN&&empty($options['base_path'])?'':$options['base_path'].DS);
      $path = rtrim($base_path.$path, DS);

      if (!file_exists($path)){
          Ak::make_dir(dirname($path), $options);
          return mkdir($path);
      }else{
          return true;
      }
      
      return false;
  }
  static function &_staticVar($name, &$value = null, $destruct = false) {
      static $_memory;
      if(!constant('TPV_CAN_FORK') || (!$pid = getmypid())){
          $pid = 0;
      }

      $null = null;
      $true = true;
      $false = false;
      $return = $null;
      if ($value === null && $destruct === false) {
          /**
           * GET mode
           */
          if (isset($_memory[$pid][$name])) {
              $return = $_memory[$pid][$name];
          }
      } else if ($value !== null) {
          /**
           * SET mode
           */
          if (is_string($name)) {
              $_memory[$pid][$name] = $value;
              $return = $true;
          } else {
              $return = $false;
          }

      } else if ($destruct === true) {
          if ($name !== null) {
              $value = isset($_memory[$pid][$name])?$_memory[$pid][$name]:$null;
              if (is_object($value) && method_exists($value,'__destruct')) {
                  $value->__destruct();
              }
              unset($value);
              unset($_memory[$pid][$name]);
          } else {
              foreach ($_memory[$pid] as $name => $value) {
                  Ak::unsetStaticVar($name);
              }
          }
      }
      return $return;
  }
  /**
  * Strategy for unifying in-function static vars used mainly for performance improvements framework-wide.
  *
  * Before we had
  *
  *     class A{
  *       static function b($var){
  *         static $chache;
  *         if(!isset($cache[$var])){
  *           $cache[$var] = some_heavy_function($var);
  *         }
  *         return $cache[$var];
  *       }
  *     }
  *
  * Now imagine we want to create an application server which handles multiple requests on a single instantiation, with the showcased implementation this is not possible as we can't reset $cache, unless we hack badly every single method that uses this strategy.
  *
  * We can refresh this static values the new Ak::getStaticVar method. So from previous example we will have to replace
  *
  *     static $chache;
  */
  static function &getStaticVar($name) {
      $refhack = Ak::_staticVar($name);
      return $refhack;
  }
  /**
   * Use this function for securing includes. This way you can prevent file inclusion attacks
   */
  static function sanitize_include($include, $mode = 'normal') {
      $rules = array(
      'paranoid' => '/([^A-Z^a-z^0-9^_^-^ ]+)/',
      'high' => '/([^A-Z^a-z^0-9^_^-^ ^\/^\\\^:]+)/',
      'normal' => '/([^A-Z^a-z^0-9^_^-^ ^\.^\/^\\\]+)/'
      );
      $mode = array_key_exists($mode,$rules) ? $mode : 'normal';
      return preg_replace($rules[$mode],'',$include);
  }
}
/**
* AkInflector for pluralize and singularize English nouns.
*
* This AkInflector is a port of Ruby on Rails AkInflector.
*
* It can be really helpful for developers that want to
* create frameworks based on naming conventions rather than
* configurations.
*
* You can find the inflector rules in config/inflector.yml
* To add your own inflector rules, please do so in config/inflector/mydictionary.yml
*
* Using it:
*
* AkInflector::pluralize('inglés',null,'es'); // ingleses, see config/inflector/es.yml
*
* @author Bermi Ferrer Martinez <bermi a.t bermilabs c.om>
* @license GNU Lesser General Public License <http://www.gnu.org/copyleft/lesser.html>
*/
class AkInflector
{
  static function underscore($word) {
      static $_cached;
      if(!isset($_cached[$word])){
          $_cached[$word] = strtolower(preg_replace(
          array('/[^A-Z^a-z^0-9^\/]+/','/([a-z\d])([A-Z])/','/([A-Z]+)([A-Z][a-z])/'),
          array('_','\1_\2','\1_\2'), $word));
      }
      return $_cached[$word];
  }
}
?>