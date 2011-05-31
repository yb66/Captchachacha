# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)


Gem::Specification.new do |s|
  s.name           = "captchachacha"
  s.summary        = "Captchator for sinatra"
  s.description = <<-EOF
    Captchator helpers for sinatra.
  EOF
  s.version        = "0.0.1"
  s.platform       = Gem::Platform::RUBY
  s.require_paths  << 'ext'
  s.required_ruby_version    = ">= 1.9.1"
  s.author         = "Iain Barnett"
  s.files          = ['Rakefile', 'captchachacha.gemspec']
  s.files          += Dir['lib/**/*.rb']
  s.add_dependency('ick', '=0.3.0')
  s.email          = "iainspeed @nospam@ gmail.com"
  s.test_files     = Dir.glob('spec/*.rb')
  s.signing_key    = ENV['HOME'] + '/.ssh/gem-private_key.pem'
  s.cert_chain     = [ENV['HOME'] + '/.ssh/gem-public_cert.pem']
end
