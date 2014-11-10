require 'rubygems'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_parameter_defaults')

desc "Run syntax, lint, and spec tests."
task :test => [
:lint,
:spec
]
