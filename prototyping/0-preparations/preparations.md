# Preparations

In order to get your Mac* setup for prototyping with HAML/SASS/Ruby etc. (— if some of the acronyms are unknown, don't worry) we will need to install and configure a few things.
Some of the steps might take a while to complete, so it's a good idea to get this started beforehand.

[DISCLAIMER: Some of the following items are based on my personal pereference and might have valid alternatives.]

For some of the steps you will need to "execute code in the Terminal". And by execute I usually mean "copy a line of code into the Terminal application (Applications > Utilities > Terminal) and hit <Enter>". If you feel uncomfortable with any of this, simply stop and we will continue together.

**ATTENTION! Sometimes you will need to modify a line of code before you execute it, to match your personal environment. Read the instructions carefully before running anything.**

## **Ruby** — Ruby comes pre installed with OS X since Leopard, so unless you're running a fairly outdated version of OS X, you should have it already and _don't have to do anything_ for now. — We'll update Ruby further below, though.

To check, open your Terminal application, type `ruby -v` and you should see something like this:

```bash
ruby 1.8.7 (2010-01-10 patchlevel 249) [universal-darwin11.0]
```

## **Editor** — We will need a text editor to work on our prototype and pretty much any editor with some syntax highlighting will do. However, if you don't have anything installed yet, I recommend [Textmate](Download a free trial ar http://macromates.com/) or [Sublime Text 2](http://www.sublimetext.com/2).

Textmate will provide you with a `mate` command which let's you open files and folders easily (of course you can use the file menues as usual).

If, for whatever reasons, the `mate` command is not available in your Terminal, you should be able to “activate” it like this:

```bash
ln -s /Applications/TextMate.app/Contents/Resources/mate ~/bin/mate
```

## **Xcode** — In order to be able to proceed any further, we will need to download and install Apple’s Developer Tools. You can get them through the App Store by simply searching for "Xcode". More information can be found at [Apple's developer pages](https://developer.apple.com/xcode/).

If you don't have the App Store available, you can download it directly by signing in to [Apple's developer section](http://developer.apple.com/downloads) with your Apple ID. Note, that you have to be [registered](https://developer.apple.com/programs/register/) as an Apple developer in this case.

***

Go, have a cup of tea. This will take a while.

***

## **Homebrew** — Homebrew is a package manager for OS X. Simplified put, it helps you install bits of software more easily from the command line. Very helpful in many cases!

You can install Homebrew by running the following in your Terminal:

```bash
/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
```

## **Git** — Git is a version control system and while not 100% necessary for now, we'll be needing it sooner or later. Thanks to Homebrew, we can now just run the following line in the Terminal to install it:

```bash
brew install git
```

## **RVM** — RVM is the Ruby Version Manager, which will help us to update Ruby, to install multiple versions and overall to keep things tidy. To install RVM, execute the following line in your Terminal:

```bash
bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
```

Before you proceed, close your terminal and open it again. Otherwise `rvm` won't be available.

## **Updating Ruby** — Ruby 1.8.7 is fairly old by now and we should install a newer version, the latest at time of writing is 1.9.3.

We can use RVM, which we just installed to do that:

```bash
rvm install 1.9.3
```

Due to changes that came with Xcode for Lion, this will fail for some people. In this case try:

```bash
rvm install 1.9.3 --with-gcc=clang
```

In order to make version 1.9.3 the new default on your system, once the installation has completed run:

```bash
rvm use 1.9.3-p125 --default
```

To check if you were successful, use:

```bash
ruby -v
```

which should yield something similiar to this:

```bash
ruby 1.9.3p125 (2012-02-16 revision 34643) [x86_64-darwin11.3.0]
```

***

Good time for a break. The worst part is over.

***

## **Install Bundler** — [Bundler](http://gembundler.com/) will help you manage the (few) dependencies for your prototype.

```bash
gem install bundler
```

## **Create a project folder** — Let's say you keep your projects under a folder called `/projects` and want to create a new project called `my-app` use `mkdir` (**m**ake **dir**ectory). I will use this fictional application also in further steps.

```bash
mkdir projects/my-app
```

## **Create a .rvmrc file** — Since we have installed RVM, let's make use of it's capabilities to keep things tidy. RVM allows us to keep sets of gems (Ruby programs, usually dependencies of your app) in groups together. A `.rvmrc` file at the root of the project will tell RVM to use a certain version of Ruby and a certain set of gems when navigating to this folder (replace `projects/my-app` and `my-app` according to your needs):

```bash
touch projects/my-app/.rvmrc
echo rvm_gemset_create_on_use_flag=1 >> projects/my-app/.rvmrc
echo rvm use ruby-1.9.3@my-app >> projects/my-app/.rvmrc
```

This will create the `.rvmrc` file and write two lines to it. **Make sure that the paths in these lines match your project's location!**

Now navigate to your project folder (you might need this command later as well to get back to your project after restarting your computer e.g.):

```bash
cd projects/my-app
```

and you should see something like this:

```bash
==============================================================================
= NOTICE                                                                     =
==============================================================================
= RVM has encountered a new or modified .rvmrc file in the current directory =
= This is a shell script and therefore may contain any shell commands.       =
=                                                                            =
= Examine the contents of this file carefully to be sure the contents are    =
= safe before trusting it! ( Choose v[iew] below to view the contents )      =
==============================================================================
Do you wish to trust this .rvmrc file? (/Users/polarblau/Projects/foo/.rvmrc)
y[es], n[o], v[iew], c[ancel]>
```

Press `y` to accept the file you have just created as trusted.

## **Serve**
Open your project in your editor — in case of textmate you can e.g. use:

```bash
mate .
```

Now create a new file called `Gemfile` in your editor and add the following lines:

```ruby
source :rubygems

gem 'serve'
gem 'haml'
gem 'sass'
```

Return to the Terminal and execute:

```bash
bundle install
```

This will load the three gems we have just specified from the source (rubygems.org) and install them for the current project.

Almost there …
`serve` provides a generator which will get us started with a basic file structure.

Usually you'd use the generator like this (from your Terminal).

```bash
serve create foobar
```

which would generate a serve project called **foobar** in the current directory.

Since we have already created the directory and a Gemfile, we can now just use

```bash
serve create .
```

to place the files in the current directory.

## **Configure serve** — (Last step with "configure" in the title for now).

Return to your editor and open `config.ru`
Then *replace* the entire content with this:

```ruby
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
```

## **Done!** — Start your server from the Terminal with

```bash
serve
```

and open a browser window at

```bash
http://localhost:4000
```
