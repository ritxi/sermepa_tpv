module TPV
  module Crypt
    class HexDec
      def initialize(key,separator=';')
        @key = key
        @separator = separator
        hex_array
      end
      def array
        @hex_array
      end
      private
      def hex_array
        @hex_array = @key.split(@separator)
        @hex_array.map!{|hex| hex.to_i(16)}
      end
    end

    class StringDec
      def initialize(key)
        @key = key
        string_array
      end  
      def array
        @string_array
      end
      def string_array
        @string_array = []
        @key.size.times do |t|
          @string_array << @key[t]
        end
      end
    end
    def self.sha1 value
      Digest::SHA1.hexdigest(value).upcase
    end
    
    # Dark key: crypted key used to sign transactions
    # keycode: part of the shine_key
    # shine_key: key used to decrypt dark key. It's composed  
    #            by keycode(8 digits), merchant_code(9 first 
    #            characters) and ***. It's a 20 digits key.

    def dark_key_file= file
      file_route = File.exist?(file) ? file : File.exist?(File.join TPV::Base::CONFIG_DIR, file ) ? File.join(TPV::Base::CONFIG_DIR,file) : nil
      raise "File especified(#{file}) not found" if file_route.nil?
      key = File.get_content(file_route)
      @dark_key= key
    end
  
    # Decodes de dark_key to obtain the real key using generate_shine_key
    # It's a XOR operation between dark_key and shine_key
    def deofuscate_key
      string_source = StringDec.new(generate_shine_key)
      hex_source = HexDec.new(dark_key)
      code_decimal = []
      hex_source.array.size.times do |index|
        code_decimal << (hex_source.array[index] ^ string_source.array[index]).chr
      end
      return code_decimal.to_s
    end
    
    
    def generate_shine_key
      raise "Key code size must be 8" unless keycode.size == 8
      raise "Merchant code size must be greather than 9" unless merchant_code.size > 9
      shine_key = "#{keycode}#{merchant_code[0,9]}***"
      raise "Shine key size must be 20" unless shine_key.size == 20
      return shine_key
    end
    
  end
  module Config
    def load(options={})
      options = {:file => 'tpv.yml'}.merge(options)
      if(@config.empty?)
        file = File.join(TPV::Base::CONFIG_DIR,options[:file])
        raise "#{file} is missing" unless File.exist?(file)
        @config = YAML::load(ERB.new(IO.read(file)).result)
        if @config.key?(TPV::Base::Modes::CURRENT)
          @config[TPV::Base::Modes::CURRENT].each_pair do |conf, value|
            if self.respond_to? "#{conf}="
              (conf=='language' || conf=='currency') && eval("defined?(#{value})") == 'constant' && value = eval("#{value}")
              send "#{conf}=", value
              #puts "#{conf} : #{value}"
            else
              @unknown_properties << conf
            end
          end 
        else
          raise "Undefined mode '#{TPV::Base::Modes::CURRENT}' in tpv.yml"
        end
      end
      @unknown_properties.size
    end
  end
end