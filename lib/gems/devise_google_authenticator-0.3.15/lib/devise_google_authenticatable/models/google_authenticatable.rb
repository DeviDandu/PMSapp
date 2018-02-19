require 'rotp'

module Devise # :nodoc:
  module Models # :nodoc:

    module GoogleAuthenticatable

      def self.included(base) # :nodoc:
        base.extend ClassMethods

        base.class_eval do
          before_validation :assign_auth_secret, :on => :create
          include InstanceMethods
        end
      end

      module InstanceMethods # :nodoc:
        def get_qr
          self.gauth_secret
        end

        def set_gauth_enabled(params)
          self.update_without_password(params)
        end

        def assign_tmp
          self.update_attributes(:gauth_tmp => ROTP::Base32.random_base32(32), :gauth_tmp_datetime => DateTime.now)
          self.gauth_tmp
        end

        def validate_token(token)

          return false if self.gauth_tmp_datetime.nil?
          if self.gauth_tmp_datetime < self.class.ga_timeout.ago
            return false
          else
         
            if  self.gauth_enabled.to_i == 0
              backup_code= ROTP::TOTP.new(self.get_qr).at(rand(10.years).seconds.ago)
               self.update(backup_code: backup_code)
            end

            valid_vals = []
            backup_code = self.backup_code
            valid_vals << backup_code

            valid_vals << ROTP::TOTP.new(self.get_qr).at(Time.now)
            (1..self.class.ga_timedrift).each do |cc|
              valid_vals << ROTP::TOTP.new(self.get_qr).at(Time.now.ago(60*cc))
              valid_vals << ROTP::TOTP.new(self.get_qr).at(Time.now.in(60*cc))
            end
            
            if  self.gauth_enabled.to_i != 0
               backup_code=nil
               self.update(backup_code: backup_code)
            end


            puts "------------"
            puts backup_code
            puts "------------"
            puts valid_vals.inspect
            puts valid_vals[0].class
            puts token
          # puts valid_vals.include?(token)
            puts backup_code

            if valid_vals.include?(token.to_s)
              return true
            else
              return false
            end
          end
        end

        def gauth_enabled?
          # Active_record seems to handle determining the status better this way
          if self.gauth_enabled.respond_to?("to_i")
            if self.gauth_enabled.to_i != 0
              return true
            else
              return false
            end
          # Mongoid does NOT have a .to_i for the Boolean return value, hence, we can just return it
          else
            return self.gauth_enabled
          end
        end

        def require_token?(cookie)
          if self.class.ga_remembertime.nil? || cookie.blank?
            return true
          end
          array = cookie.to_s.split ','
          if array.count != 2
            return true
          end
          last_logged_in_email = array[0]
          last_logged_in_time = array[1].to_i
          return last_logged_in_email != self.email || (Time.now.to_i - last_logged_in_time) > self.class.ga_remembertime.to_i
        end

        private

        def assign_auth_secret
          self.gauth_secret = ROTP::Base32.random_base32(64)
        end

      end

      module ClassMethods # :nodoc:
        def find_by_gauth_tmp(gauth_tmp)
          where(gauth_tmp: gauth_tmp).first
        end
        ::Devise::Models.config(self, :ga_timeout, :ga_timedrift, :ga_remembertime, :ga_appname, :ga_bypass_signup)
      end
    end
  end
end
