#\ -p 4000

require 'rubygems'
require 'bundler/setup'
require 'serve'
require 'haml'
require 'sass'
require 'sass/plugin/rack'

# The project root directory
RACK_ROOT = ::File.dirname(__FILE__)

# Middleware
use Sass::Plugin::Rack # Compile SASS

# http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#output_style
Sass::Plugin.options.merge!(:template_location => 'stylesheets', :style => :expanded, :trace_selectors => true)

# Compile Sass on the fly with the Sass plugin
if ENV['RACK_ENV'] != 'production'
  # Compile SASS to tmp directory
  require 'fileutils'
  FileUtils.mkdir_p(RACK_ROOT + '/tmp/stylesheets')
  use Rack::Static, :urls => ['/stylesheets'], :root => RACK_ROOT + '/tmp'
  Sass::Plugin.options.merge!(:css_location => 'tmp/stylesheets', :line_numbers => false)
end

# Other Rack Middleware
use Rack::ShowStatus      # Nice looking 404s and other messages
use Rack::ShowExceptions  # Nice looking errors

# Rack Application
run Rack::Cascade.new([
  Serve::RackAdapter.new(RACK_ROOT + '/views'),
  Rack::Directory.new(RACK_ROOT + '/public')
])