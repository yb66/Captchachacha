# encoding: utf-8

require_relative './captchachacha/helpers.rb'

module Rack
  
  class Captchachacha
    
    VERIFY_URL = "http://captchator.com/captcha/check_answer"
    CHALLENGE_FIELD = 'captcha_session'
    RESPONSE_FIELD  = 'captcha_answer'
    
    
    # @param app Rack application
    # @param [optional,Hash] options Hash of options
    # @option options [String, Array<String>] paths Where user goes to login or access the captcha.
    def initialize( app, options={} )
      @app = app
      
      # this is here because it's in the Rack::Recaptcha API, I've no idea what it does really.
      @paths = options[:paths] && [options[:paths]].flatten.compact
    end

    def call(env)
      dup._call env
    end

    # @param env Rack environment
    def _call(env)
      request = Request.new(env)
      
      if request.params[CHALLENGE_FIELD] && request.params[RESPONSE_FIELD]
        
        result, msg = verify(
                        request.params[CHALLENGE_FIELD].to_i, 
                        request.params[RESPONSE_FIELD] )
                        
        # captchator doesn't give an error message, but in the spirit of keeping a similar API
        # to reCAPTCHA, and because it's an easy place to stick a default error message, I'll
        # pretend that `verify` returns two results.
        # If it's a fail then the usual course of action would be to redirect back to the
        # captcha form, but on success to continue, so the error message will be ignored unless
        # of failure.
        msg ||= "incorrect response, please try again"
        
        env.merge!('X-Captcha-Valid' => result == true, 'X-Captcha-Msg' => msg )
      end
      @app.call(env)
    end
    
    
    def verify( session_id, answer )
      return false if session_id == 0 || session_id.nil?
      return false if answer.nil?
    
      require 'curb'
      Curl::Easy.perform("#{VERIFY_URL}/#{session_id}/#{answer}").body_str == "1"
    end # def
    
  end # class
  
end # Rack