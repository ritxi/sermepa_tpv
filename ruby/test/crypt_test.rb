require "test/unit"
%w(constants util ruby_utils).each{|file| require "#{File.dirname(__FILE__)}/../lib/#{file}"}

class Cryptography
  include TPV::Crypt
  attr_accessor :dark_key, :keycode, :merchant_code
  def initialize(options={})
    options.each_pair {|key,value|  self.respond_to?("#{key}=".to_sym) && send("#{key}=",value)}
    @dark_key ||= "5D;7F;0A;27;09;0D;25;5D;04;01;0B;00;06;01;00;70;06;1C;19;19"
    @keycode ||= "eH2dJ9gk"
    @merchant_code ||= "B82915026das"
  end
end
class TestCryptModule < Test::Unit::TestCase
  def test_undark_key
    crypt = Cryptography.new
    
    assert_equal "878CC4B6F999740B0633", crypt.deofuscate_key
  end
  
  def test_dark_key
    dark_key = "5D;7F;0A;27;09;0D;25;5D;04;01;0B;00;06;01;00;70;06;1C;19;19"
    h = TPV::Crypt::HexDec.new dark_key

    assert_equal([93, 127, 10, 39, 9, 13, 37, 93, 4, 1, 11, 0, 6, 1, 0, 112, 6, 28, 25, 25], h.array)
  end
  
  def test_shine_key
    shine_key = "eH2dJ9gkB82915026***"
    s = TPV::Crypt::StringDec.new shine_key
    assert_equal [101, 72, 50, 100, 74, 57, 103, 107, 66, 56, 50, 57, 49, 53, 48, 50, 54, 42, 42, 42], s.array
    crypt = Cryptography.new
    assert_equal "eH2dJ9gkB82915026***", crypt.generate_shine_key
    
    crypt.merchant_code= "B82915026"
    assert_raise(RuntimeError) { crypt.generate_shine_key }
    crypt.merchant_code= "B82915026das"
    crypt.keycode= "eH2dJ9g"
    assert_raise(RuntimeError) { crypt.generate_shine_key }
  end
  
  def test_load_dark_key_file
    crypt = Cryptography.new(:dark_key => 'alkjsdlkñadjf')
    assert_equal("alkjsdlkñadjf", crypt.dark_key)
    puts crypt.dark_key
    crypt.dark_key_file ='dark.test.key'
    assert_equal("06;0B;03;0D;0C;0F;0E;0E;73;73;03;03;77;05;02;06;06;1A;1F;6E", crypt.dark_key)
  end
end