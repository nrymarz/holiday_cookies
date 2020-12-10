require_relative 'lib/holiday_cookies/version'

Gem::Specification.new do |spec|
  spec.name          = "holiday_cookies"
  spec.version       = HolidayCookies::VERSION
  spec.authors       = ["nrymarz"]
  spec.email         = ["nrymarz@gmail.com"]

  spec.summary       = %q{Holiday Cookie Recipe Content Manage System.}
  spec.homepage      = "https://github.com/nrymarz/holiday_cookies"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nrymarz/holiday_cookies"
  spec.metadata["changelog_uri"] = "https://github.com/nrymarz/holiday_cookies"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "shotgun"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "tux"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "open-uri"
  spec.add_dependency "sinatra"
  spec.add_dependency "sqlite3"
  spec.add_dependency "thin"
  spec.add_dependency "bcrypt"
  spec.add_dependency "require_all"
end

