# Copyright (c) 2010-2013 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module AwesomePrint
  module IcalComponent
    def self.included(base)
      base.send :alias_method, :cast_without_ical_component, :cast
      base.send :alias_method, :cast, :cast_with_ical_component
    end

    def cast_with_ical_component(object, type)
      cast = cast_without_ical_component(object, type)
      if defined?(::Icalendar) && object.is_a?(::Icalendar::Component)
        cast = :ical_component_instance
      end
      cast
    end

    def awesome_ical_component_instance(object)
      "#{object.class} #{awesome_hash(object.to_hash)}"
    end
  end
end

AwesomePrint::Formatter.send(:include, AwesomePrint::IcalComponent)
