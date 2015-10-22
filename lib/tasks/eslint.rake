ENV['EXECJS_RUNTIME'] = 'RubyRacer'

require 'eslint-rails'

namespace :eslint do

  desc %{Run ESLint against the specified JavaScript file and report warnings (default is 'application')}
  task :run, [:filename] => :environment do |_, args|
    puts 'Running ESLint Rails...'
    warnings = ESLintRails::Runner.new(args[:filename]).run

    if warnings.empty?
      puts 'ESLint inspected, no offenses detected'
    else
      formatter = ESLintRails::TextFormatter.new(warnings)
      formatter.format
      abort('ESLint Rails failed!')
    end
  end

  desc 'Print the current configuration file (Uses local config/eslint.json if it exists; uses default config/eslint.json if it does not; optionally force default by passing a parameter)'
  task :print_config, [:force_default] => :environment do |_, args|
    puts ESLintRails::Config.read(force_default: args[:force_default])
  end
end
