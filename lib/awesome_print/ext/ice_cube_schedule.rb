# Copyright (c) 2010-2013 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module AwesomePrint
  module IceCubeSchedule
    def self.included(base)
      base.send :alias_method, :cast_without_ice_cube_schedule, :cast
      base.send :alias_method, :cast, :cast_with_ice_cube_schedule
    end

    def cast_with_ice_cube_schedule(object, type)
      cast = cast_without_ice_cube_schedule(object, type)
      if defined?(::IceCube) && object.is_a?(::IceCube::Schedule)
        cast = :ice_cube_schedule_instance
      end
      cast
    end

    def awesome_ice_cube_schedule_instance(object)
      "#{object.class} #{awesome_hash(object.to_hash)}"
    end
  end
end

AwesomePrint::Formatter.send(:include, AwesomePrint::IceCubeSchedule)
