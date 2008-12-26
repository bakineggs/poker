require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
    s.platform  =   Gem::Platform::RUBY
    s.name      =   "poker"
    s.version   =   "1.0.2"
    s.author    =   "Dan Barry"
    s.email     =   "dan@bakineggs.com"
    s.summary   =   "A library for constructing and comparing poker hands. Also provides a deck of cards."
    s.files     =   FileList['lib/*.rb'].to_a
end

Rake::GemPackageTask.new(spec) do |pkg|
end
