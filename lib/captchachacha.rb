# encoding: utf-8

require 'sinatra/base'
require "ick"

Ick.sugarize

module Sinatra

  # @author Iain Barnett
  #
  # an module to take advantage of the http://captchator.com service
  module Captchachacha
  
    def captcha_pass?( session_id, answer )
      sesh = session_id.to_i # here, set session_id to a number or 0
      ans = answer.maybe.gsub(/\W/, '') # substitute non word chars
      
      return if sesh == 0
      return if ans.nil?
      
      does_it_pass = get_uri( sesh, ans )
      return does_it_pass
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
    
    private
      def get_uri( session_id, answer )
        require 'open-uri'
          url = "http://captchator.com/captcha/check_answer/#{session_id}/#{answer}"
          result = open(url).read.to_i.nonzero? rescue false
          options.logger.debug "captcha get_uri returned #{result}"
          result
      end
    
  end # Captcha
  
  helpers Captchachacha
  
end # module