# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'jasny-bootstrap-extension-rails/version'

Gem::Specification.new do |s|
  s.name = 'jasny-bootstrap-extension-rails'
  s.version = Jasny::Bootstrap::Extension::Rails::VERSION
  s.summary = "http://jasny.github.com/bootstrap/index.html"
  s.description = s.summary

  s.authors = ["Maciej Podsiedlak"]
  s.email = ["kragear@gmail.com"]
  s.homepage = "https://github.com/Kraku/jasny-bootstrap-extension-rails"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end