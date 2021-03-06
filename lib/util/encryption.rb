module Util
  class Encryption
    class << self
      def encrypt(data)
        encryptor.encrypt_and_sign(data)
      end

      def decrypt(data)
        encryptor.decrypt_and_verify(data)
      end

      private

      def encryptor
        key = Rails.application.credentials.secret_key_base[0..31]
        @encryptor ||= ActiveSupport::MessageEncryptor.new(key)
      end
    end
  end
end
