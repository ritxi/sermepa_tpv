unless defined?(TPV_LOADED)
  TPV_LOADED = true
  module TPV
    module Base
      (defined?(RAILS_ROOT) && ROOT = Rails.root) || ROOT = '/Users/ricard/develop/sermepa_tpv'
      TMP_DIR = File.join(ROOT,'tmp')
      CONFIG_DIR = File.join(ROOT,'config')

      MODES = %w(setup test testing development production staging)
      module Modes
        defined?( CURRENT           ) || (defined?(RAILS_ENV) && CURRENT = RAILS_ENV) || CURRENT = 'development'
      
        DEV_MODE        = CURRENT == 'development'
        TEST_MODE       = (CURRENT == 'testing' || CURRENT == 'test')
        STAGING_MODE    = CURRENT == 'staging'
        PRODUCTION_MODE = CURRENT == 'production'
      end
    end
    module Sermepa
      CURRENCY = %w(EUR USD GBP YEN)
      LANGUAGE = %w(CASTILIAN ENGLISH CATALAN FRENCH GERMAN DUTCH ITALIAN SWEDISH PORTUGUESE POLISH GALICIAN BASQUE)
      module Currency
        EUR    = 978 #EURO
        USD    = 840 #US Dolar
        GBP    = 826 #British Pound
        YEN    = 392 #Japanese Yen
      end
      module Language
        CASTILIAN  = '001'
        ENGLISH    = '002'
        CATALAN    = '003'
        FRENCH     = '004'
        GERMAN     = '005'
        DUTCH      = '006'
        ITALIAN    = '007'
        SWEDISH    = '008'
        PORTUGUESE = '009'
        POLISH     = '011'
        GALICIAN   = '012'
        BASQUE     = '013'
      end
    end
    module Bbva
      PAYMENT_METHODS = 4
      CARD            = 1 #soporte
      STATUSES        = %w(PROCESSING ACCEPTED DENIED UNPROCESSED NULLED)
      PAYMENT_MODELS  = %w(SECURE_3D REFERENCE)
      CHANNELS        = %w(INTERNET WAP)
      CURRENCIES      = %w(EUR USD GBP YEN)
      LANGUAGES       = %w(CASTILLIAN CATALAN ENGLISH FRENCH)
      COUNTRIES       = %w(SPAIN FRANCE GREATBRITAN)
      RESPONSES       = %w(VALID FAKE REJECT UNFORMATED)
      module Responses
        VALID      = 0
        REJECTED   = 1
        UNFORMATED = 2
        FAKE       = 3
      end
      module Statuses
        PROCESSING  = 1
        ACCEPTED    = 2
        DENIED      = 3
        UNPROCESSED = 4
        NULLED      = 5
      end
      module PaymentModels
        SECURE_3D = 4
        REFERENCE = 5
      end
      module Channels
        INTERNET = 1
        WAP      = 2
      end
      module Currencies
        EUR = 978 #EURO
        USD = 840 #US Dolar
        GBP = 826 #British Pound
        YEN = 392 #Japanese Yen
      end
      module Languages
        CATALAN    = 'ca'
        CASTILLIAN = 'es'
        FRENCH     = 'fr'
        ENGLISH    = 'en'
      end
      module Countries
        SPAIN       = 'ES'
        FRANCE      = 'FR'
        GREATBRITAN = 'GB'
      end
    end
  end

  if defined?(OLD)
    defined?( BASE               ) || (defined?(RAILS_ROOT) && BASE = RAILS_ROOT) || BASE = '/Users/ricard/develop/sermepa_tpv'
    defined?( TMP_DIR            ) || TMP_DIR = File.join(BASE,'tmp')
    defined?( TPV_CONFIG_DIR     ) || TPV_CONFIG_DIR = File.join(BASE,'config')
    defined?( TPV_AVAILABLE_MODES) || TPV_AVAILABLE_MODES = %w(setup testing development production staging)
    defined?( TPV_MODE           ) || (defined?(RAILS_ENV) && TPV_MODE = RAILS_ENV) || TPV_MODE = 'development'
    defined?( TPV_DEV_MODE       ) || TPV_DEV_MODE =        TPV_MODE == 'development'
    defined?( TPV_TEST_MODE      ) || TPV_TEST_MODE =       (TPV_MODE == 'testing' || TPV_MODE == 'test')
    defined?( TPV_STAGING_MODE   ) || TPV_STAGING_MODE =    TPV_MODE == 'staging'
    defined?( TPV_PRODUCTION_MODE) || TPV_PRODUCTION_MODE = TPV_MODE == 'production'

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
  end
end