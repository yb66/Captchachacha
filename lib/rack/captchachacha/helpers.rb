# encoding: utf-8


# @author Iain Barnett
#
# A module to take advantage of the http://captchator.com service
module Rack
  class Captchachacha
    module Helpers
      require 'securerandom'
      
      def captcha_valid?
        request.env['X-Captcha-Valid']
      end # def


      def captcha_session
        @captcha_session ||= SecureRandom.random_number.to_s[2..-1]
      end


      def captcha_answer_tag
        %Q!<input id="captcha_answer" name="captcha_answer" type="text" size="6"/>!
      end


      def captcha_image_tag
        %Q!<input id="captcha_session" name="captcha_session" type="hidden" value="#{captcha_session}"/><img id="captcha_image" src="http://captchator.com/captcha/image/#{captcha_session}"/>!
      end
 
    end # Helpers
  end # Captchachacha 
end # Rack