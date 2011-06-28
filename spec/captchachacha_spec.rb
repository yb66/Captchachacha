require 'rspec'
require 'rack/test'
require 'rack/mock'
require 'curb'
require 'webmock/rspec'
require 'securerandom'

require_relative '../lib/rack/captchachacha.rb'


describe "Rack::Captchachacha" do
include Rack::Test::Methods
  
  before do
    WebMock.reset! 
    WebMock.disable_net_connect! 
  end
  
  def app
    main_app = lambda { |env|
      request = Rack::Request.new(env)
      return_code, body_text =
      case request.path
      when '/' then [200,'Hello world']
      when '/login'
        if request.post?
          env['X-Captcha-Valid'] ? [200, 'post login'] : [200, 'post fail']
        else
          [200,'login']
        end
      else
        [404,'Nothing here']
      end
      [return_code,{'Content-type' => 'text/plain'}, [body_text]]
    }

    builder = Rack::Builder.new
    builder.use Rack::Captchachacha
    builder.run main_app
    builder.to_app
  end
  
  context "basic request" do
    it "is a 200 ok response code" do
      get("/")
      last_response.status == 200
    end
    it "should say hello" do
      get("/")
      last_response.body == "Hello world"
    end
  end # context
  
  context "a page that requires a captcha" do
    let(:session_id){ SecureRandom.random_number.to_s[2..-1] }
    let(:url_to_request) { "#{Rack::Captchachacha::VERIFY_URL}/#{session_id}/response" }
    
    it "should pass the captcha" do
      stub_request(:get, url_to_request).to_return({:body => "1"})
      post "/login", {'captcha_session' => session_id, 'captcha' => 'response'}
      
      WebMock.should have_requested(:get, url_to_request)
        
      last_response.status.should == 200  
      last_response.body.should == 'post login'
    end
    
    
    it "should fail the captcha" do
      stub_request(:get, url_to_request).to_return({:body => "0"})
      post "/login", {'captcha_session' => session_id, 'captcha' => 'response'}
      
      WebMock.should have_requested(:get, url_to_request)
    
      last_response.status.should == 200  
      last_response.body.should == 'post fail'
    end
  end # context
end 