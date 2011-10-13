require "permalinker/permalinker"
require "permalinker/version"

ActiveRecord::Base.send :include, Permalinker
