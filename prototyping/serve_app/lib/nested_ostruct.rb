require 'ostruct'

class NestedOstruct < OpenStruct
  undef :class
  def self.new(hash)
    hash.each_pair do |key, value|
      hash[key] = self.import(value)
    end
    super(hash)
  end
  def self.import(data)
    case data
      when Array
        data.map{ |item| self.import(item) }
      when Hash
        self.new(data)
      else
        data
    end
  end
  def method_missing(sym, *args, &block)
    if sym.to_s =~ /\?$/
      key = sym.to_s.gsub(/\?$/, '')
      value = self.send(key.to_sym)
      if value.respond_to?(:empty?)
        !value.empty?
      else
        value
      end
    else
      "missing key: #{sym}"
    end
  end
end