module Permalinker
  extend ActiveSupport::Concern
  
  included do
    alias :to_param_without_permalink :to_param
  end
  
  module ClassMethods
    def permalink(method_name=nil, &block)
      mattr_accessor :_permalink_generator
      if block_given?
        self._permalink_generator = block
      elsif method_name.present? && method_name.is_a?(Symbol)
        self._permalink_generator = lambda { send(method_name) }
      else
        raise NoPermalinkMethod, 'need to specify permalink method name or block'
      end
      
      define_method :with_permalink do
        self.extend(Enable)
      end
    end
  end
  
  module InstanceMethods
    def without_permalink
      self.extend(Disable)
    end
  end
  
  module Disable
    def to_param
      to_param_without_permalink
    end
  end
  
  module Enable
    def to_param
      instance_exec(&self.class.send(:_permalink_generator))
    end
  end
  
  class NoPermalinkMethod < StandardError
  end

end