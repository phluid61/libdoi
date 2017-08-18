Gem::Specification.new do |s|
  s.name     = 'libdoi'
  s.version  = '1.0.1-dev'
  s.date     = '2017-08-18'
  s.summary  = %(DOI Library)
  s.description = <<EOS
== DOI Library

Parse, display, and dereference DOIs.

See the documentation at http://phluid61.github.io/libdoi/
EOS
  s.authors  = ['Matthew Kerwin'.freeze]
  s.email    = ['matthew@kerwin.net.au'.freeze]
  s.files    = Dir['lib/**/*.rb']
  s.test_files=Dir['test/*.rb']
  s.homepage = 'http://phluid61.github.com/libdoi'.freeze
  s.license  = 'ISC'.freeze
  s.has_rdoc = true
end
