# frozen_string_literal: true

require_relative "lib/nrql2nerd/version"

Gem::Specification.new do |spec|
  spec.name = "nrql2nerd"
  spec.version = NRQL2Nerd::VERSION
  spec.authors = ["Adam Ladachowski"]
  spec.email = ["adam.ladachowski@gmail.com"]

  spec.summary = "Send NRQL queries to New Relic API and get results in NerdGraph format"
  spec.description = "A tool to #{spec.summary}"
  spec.homepage = "https://github.com/aladac/nrql2nerd/blob/main"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = "#{spec.homepage}/blob/main/README.md"
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/aladac/nrql2nerd/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
