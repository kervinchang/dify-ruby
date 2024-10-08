# frozen_string_literal: true

require_relative "lib/dify/version"

Gem::Specification.new do |spec|
  spec.name = "dify"
  spec.version = Dify::VERSION
  spec.authors = ["Kervin"]
  spec.email = ["kervinchangyu@gmail.com"]

  spec.summary = "A Ruby client for Dify API."
  spec.description = "This gem provides a Ruby client to interact with the Dify API for chat and completion services."
  spec.homepage = "https://github.com/kervinchang/dify-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.0.0"

  # spec.metadata["allowed_push_host"] = "https://github.com/kervinchang/dify-ruby"
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "https://github.com/kervinchang/dify-ruby"
  # spec.metadata["changelog_uri"] = "https://github.com/kervinchang/dify-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
