# -*- encoding: utf-8 -*-
lib = File.expand_path('./lib')
$:.unshift lib unless $:.include?(lib)
require 'rack/captchachacha/version'

Gem::Specification.new do |s|
  s.name           = "captchachacha"
  s.summary        = "Captchator for rack with helpers for sinatra"
  s.description = <<-EOF
    Captchator as Rack middleware, and helpers for sinatra.
  EOF
  s.version        = Rack::Captchachacha::VERSION
  s.platform       = Gem::Platform::RUBY
  s.require_path   = "lib"
  s.required_ruby_version    = ">= 1.9.2"
  s.authors        = ["Iain Barnett"]
  s.files          = `git ls-files`.split("\n")
  s.add_dependency("rack", "~> 1.3.0")
  s.add_dependency("curb", "~> 0.7.15")
  s.email          = ["iainspeed @nospam@ gmail.com"]
  s.homepage       = "https://github.com/yb66/Captchachacha"
  s.test_files     = `git ls-files -- {test,spec,features}`.split("\n")
  s.signing_key    = ENV['HOME'] + '/.ssh/gem-private_key.pem'
  s.cert_chain     = [ENV['HOME'] + '/.ssh/gem-public_cert.pem']
end
