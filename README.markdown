# Thor Addon ##

## Thor Patches ##

*append_line_to_file(path, *args, &block)*

Ensures a line AND a newline character is appended to the file

*gem(*args)*

Ensures has_gem? is used to guard against duplicate gem statements in Gemfile. Calls patches append_line_to_file for a pretty Gemfile result ;) 

## Thor Extras ##

*cleanup_gemfile*

Runs through Gemfile and for every gem statement with no newline before next gem statement, a newline is inserted in between
This is however not foolproof (if ' gem ' is found in other contexts?) but works in most situations.

*has_gem?(gem_name)*

Checks if there is already a gem '...' statement for a particular gem in the Gemfile

*has_plugin?(plugin_name)*

Checks if the particular plugin is already installed

*add_gem(gem_name, gem_version = nil)*

Adds a gem statement to the Gemfile of the simple form: 

gem 'gem_name', 'version'

But only adds the gem statement if no gem statement for that gem can be found in the Gemfile (has_gem?)

*add_gems(*gem_names)

Calls add_gem for each gem_name in the array (no version or other parameters)

*gemfile_txt*
Returns the text of the Gemfile

## TODO ##

* Improve `add_gem` to allow for all the other gem parameters as options!
* Improve `add_gems` to allow for named group block sth. like:

<pre>
add_gems :test do |gems| 
  gems.add 'my_gem', '>1.0', :git => '...'
  gems.add 'my_other_gem', '>2.1', :git => '...'  
end
</pre>

=> RESULT

<pre>
group :test do
  gem 'my_gem',       '>1.0', :git => '...'
  gem 'my_other_gem', '>2.1', :git => '...'    
end
</pre>

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
