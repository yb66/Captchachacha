# encoding: utf-8


# @author Iain Barnett
#
# A module to take advantage of the http://captchator.com service
module Rack
  class Captchachacha
    module Helpers
      
      
      def captcha_valid?
        request.env['captcha.valid']
      end # def


      def captcha_session
        @captcha_session ||= rand(9000) + 1000
      end


      def captcha_answer_tag
        %Q!<input id="captcha-answer" name="captcha_answer" type="text" size="10"/>!
      end


      def captcha_image_tag
        %Q!<input name="captcha_session" type="hidden" value="#{captcha_session}"/>\n<img id="captcha-image" src="http://captchator.com/captcha/image/#{captcha_session}"/>!
      end
 
    end # Helpers
  end # Captchachacha 
end # Rack