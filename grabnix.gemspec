Gem::Specification.new do |s|
	s.platform			= Gem::Platform::RUBY
	s.name					= 'grabnix'
	s.version				= '0.1'
	s.date					= '2008-08-03'
	s.author				= 'Hans Engel'
	s.email					= 'spam.me@engel.uk.to'
	s.summary				= 'grabUp for Linux users!'
	s.files					= ['lib/grabnix.rb', 'bin/grabnix']
	
	s.bindir				= 'bin'
	s.executables		= ['grabnix']
	
	s.require_paths	= ['lib', 'bin']
end
