$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ionic_notification/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ionic_notification'
  s.version     = IonicNotification::VERSION
  s.authors     = ['Francesco Renzi']
  s.email       = ['rentziass@gmail.com']
  s.homepage    = 'https://github.com/rentziass/ionic_notification'
  s.summary     = 'Simple interface to use Ionic.io Push Notification service'
  s.description = 'Simple interface to use Ionic.io Push Notification service'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.1'
  s.add_dependency 'httparty', '~> 0.13.5'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec'
end
