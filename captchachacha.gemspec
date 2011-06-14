# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
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
  s.require_paths  = 'lib'
  s.required_ruby_version    = ">= 1.9.2"
  s.author         = "Iain Barnett"
  s.files          = `git ls-files`.split("\n")
  s.add_dependency('rack', '=1.3.0')
  s.add_dependency('curb', '=0.7.15')
  s.add_development_dependency('webmock', '=1.6.4')
  s.add_development_dependency('rack-test', '=0.6.0')
  s.add_development_dependency('rspec', '=2.6.0')
  s.email          = "iainspeed @nospam@ gmail.com"
  s.test_files     = `git ls-files -- {test,spec,features}`.split("\n")
  s.signing_key    = ENV['HOME'] + '/.ssh/gem-private_key.pem'
  s.cert_chain     = [ENV['HOME'] + '/.ssh/gem-public_cert.pem']
end
