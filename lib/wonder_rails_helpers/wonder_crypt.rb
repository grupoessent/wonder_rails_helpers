require 'openssl'
require 'openssl/cipher'
require 'logger'

module WonderRailsHelpers
  class WonderCrypt
    attr_accessor :key, :adapter, :logger

    # Cria uma instância do WonderCrypt.
    #
    # ==== Examples
    #
    #   wc = WonderCrypt.new(key: 'superpass')
    #   puts wc.adapter
    #   => "OpenSSL::Cipher::DES"
    #   wc = WonderCrypt.new(key: 'superpass', method: 'SHA5')
    #   puts wc.adapter
    #   => "OpenSSL::Cipher::SHA5"
    #   wc = WonderCrypt.new(password: 'superpass')
    #   puts wc.key
    #   => 'superpass'
    def initialize(options = {})
      @key = options[:key] || options[:password]
      @adapter = OpenSSL::Cipher.new(options[:method] || options[:cipher] || 'DES')
      @logger  = Logger.new(STDOUT)
    end

    # Retorna uma string criptografada usando a instância do WonderCrypt.
    #
    # ==== Examples
    #
    #   wc = WonderCrypt.new(key: 'password')
    #   puts wc.encrypt('secret_text')
    #   => "db72a526d3f0fb7a5d6745a4f083bf9a"
    #   wc = WonderCrypt.new(key: 'password')
    #   puts wc.encrypt('secret_text', false) # não converter para hexadecimal
    #   => "\xDBr\xA5&\xD3\xF0\xFBz]gE\xA4\xF0\x83\xBF\x9A"
    def encrypt(str, convert_hex = true)
      initialize_adapter :encrypt

      encrypted_text = adapter.update(str.to_s)
      encrypted_text << adapter.final
      encrypted_text = encrypted_text.unpack('H*').join if convert_hex

      encrypted_text
    rescue OpenSSL::Cipher::CipherError => e
      logger.error e.message

      return nil
    end

    # Retorna uma string descriptografada usando a instância do WonderCrypt.
    #
    # ==== Examples
    #
    #   wc = WonderCrypt.new(key: 'password')
    #   puts wc.decrypt('db72a526d3f0fb7a5d6745a4f083bf9a')
    #   => "secret_text"
    #   wc = WonderCrypt.new(key: 'password')
    #   puts wc.decrypt('\xDBr\xA5&\xD3\xF0\xFBz]gE\xA4\xF0\x83\xBF\x9A', false) # não converter para hexadecimal
    #   => "secret_text"
    def decrypt(str, convert_hex = true)
      initialize_adapter :decrypt

      str = [str].pack('H*') if convert_hex
      encrypted_text = adapter.update(str.to_s)
      encrypted_text << adapter.final

      encrypted_text
    rescue OpenSSL::Cipher::CipherError => e
      logger.error e.message

      return nil
    end

    private

    def initialize_adapter(method)
      adapter.send(method.to_sym)
      adapter.key = key
    end
  end
end
