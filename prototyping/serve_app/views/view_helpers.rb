require 'active_support/inflector'

I18n.load_path = Dir['locale/**/*.yml']
I18n.reload!

module ViewHelpers
  
  # Calculate the years for a copyright
  def copyright_years(start_year)
    end_year = Date.today.year
    if start_year == end_year
      "\#{start_year}"
    else
      "\#{start_year}&#8211;\#{end_year}"
    end
  end
  
  # Handy for hiding a block of unfinished code
  def hidden(&block)
    #no-op
  end
  
  def list(key, &block)
    data = t(key).clone rescue {}
    raise data if data =~ /translation missing/
    data = NestedOstruct.import(data)
    raise data unless data.is_a? Array
    data.each {|i| yield i }
  end
  
  def t(key, args={})
    I18n.t(key, args)
  end
    
end