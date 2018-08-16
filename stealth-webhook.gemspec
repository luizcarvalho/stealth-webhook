$LOAD_PATH.push File.expand_path('../lib', __FILE__)

version = File.read(File.join(File.dirname(__FILE__), 'VERSION')).strip

Gem::Specification.new do |s|
  s.name = 'stealth-webhook'
  s.summary = 'Add Webhook to Stealth'
  s.description = 'Simplify handle of payload and messages'
  s.homepage = 'https://github.com/luizcarvalho/stealth-webhook'
  s.licenses = ['MIT']
  s.version = version
  s.authors = ['Luiz Carvalho']
  s.email = 'contato@luizcarvalho.com'

  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'pry', '~> 0.10'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
