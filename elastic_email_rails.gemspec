$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'elastic_email/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'elastic_email_rails'
  s.version     = ElasticEmail::VERSION
  s.authors     = ['Zaez Team']
  s.email       = ['contato@zaez.net']
  s.homepage    = 'https://github.com/zaeznet/elastic_email_rails/'
  s.summary     = 'Rails Action Mailer adapter for Elastic Email'
  s.description = 'An adapter for using Elastic Email with Rails and Action Mailer'
  s.license = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'actionmailer', '>= 3.2.13'

  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'rails', '>= 3.2.13'
  s.add_development_dependency 'webmock', '~> 2.1.0'
end
