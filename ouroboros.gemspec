# frozen_string_literal: true

require_relative "lib/ouroboros/version"

Gem::Specification.new do |spec|
  spec.name = "ouroboros"
  spec.version = Ouroboros::VERSION
  spec.authors = ["Rob Lacey"]
  spec.email = ["contact@robl.me"]

  spec.summary = "Circular, Infinite Arrays in Ruby"
  spec.description = "Ouroboros is an experimental implementation of an infinite circular Array. An Array eating it's own tail. "
  spec.homepage = "https://github.com/braindeaf/ouroboros"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/braindeaf/ouroboros"
  spec.metadata["changelog_uri"] = "https://github.com/braindeaf/ouroboros/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

  spec.require_paths = ["lib"]
end
