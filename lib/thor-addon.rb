# needed for has_plugin? to use Rails.root
# require 'rails'
# require 'thor'

module ThorExtensions
  def append_line_to_file(path, *args, &block)
    if block_given?
      data = block
    else
      data = args.shift
    end
    append_file path, "#{data}\n"
  end

    
  def cleanup_gemfile
    # add newline between each gem statement in Gemfile
    gsub_file 'Gemfile', /('|")gem/, "\1\ngem"      
  end

  def has_gem?(text, gem_name)        
    if /\n[^#]*gem\s*('|")\s*#{Regexp.escape(gem_name)}\s*('|")/i.match(text)  
      true 
    else
      false
    end      
  end
  
  def has_plugin?(plugin_name) 
    File.directory?(File.join(Rails.root, "vendor/plugins/#{plugin_name}"))
  end

  def add_gem(gem_name, gem_version = nil)
    if !has_gem?(gemfile_txt, gem_name) 
      gem_version_str = gem_version ? ", '#{gem_version}'" : '' 
      append_line_to_file 'Gemfile', "gem '#{gem_name}'#{gem_version_str}"  
    end
  end

  def add_gems(*gem_names)
    gem_names.each{|gem_name| add_gem(gem_name) }
  end
  
  def gemfile_txt
    @gemfile_txt ||= File.open('Gemfile').read        
  end
end

module Rails
  module Generators
    module Actions
      include ThorExtensions
      
      def gem(*args)
        options = args.extract_options!
        name, version = args

        # Deal with deprecated options
        { :env => :only, :lib => :require_as }.each do |old, new|
          next unless options[old]
          options[new] = options.delete(old)
          ActiveSupport::Deprecation.warn "#{old.inspect} option in gem is deprecated, use #{new.inspect} instead"
        end

        # Deal with deprecated source
        if source = options.delete(:source)
          ActiveSupport::Deprecation.warn ":source option in gem is deprecated, use add_source method instead"
          add_source(source)
        end

        # Set the message to be shown in logs. Uses the git repo if one is given,
        # otherwise use name (version).
        parts, message = [ name.inspect ], name
        if version ||= options.delete(:version)
          parts   << version
          message << " (#{version})"
        end
        message = options[:git] if options[:git]

        log :gemfile, message

        options.each do |option, value|
          parts << ":#{option} => #{value.inspect}"
        end

        in_root do                    
          if !has_gem?(gemfile_txt, gem_name) 
            append_line_file "Gemfile", "gem #{parts.join(", ")}", :verbose => false 
          end
        end
      end
    end
  end
end