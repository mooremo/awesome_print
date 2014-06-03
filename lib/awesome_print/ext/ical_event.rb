# Copyright (c) 2010-2013 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module AwesomePrint
  module IcalEvent
    def self.included(base)
      base.send :alias_method, :cast_without_ical_event, :cast
      base.send :alias_method, :cast, :cast_with_ical_event
    end

    def cast_with_ical_event(object, type)
      cast = cast_without_ical_event(object, type)
      if defined?(::Icalendar) && defined?(::IceCube) && object.is_a?(::Icalendar::Event)
        cast = :ical_event_instance
      end
      cast
    end

    def awesome_ical_event_instance(object)
      "#{object.class} #{awesome_hash(IceCube::IcalParser.schedule_from_ical(object.to_ical).to_hash)}"
    end
  end
end

AwesomePrint::Formatter.send(:include, AwesomePrint::IcalEvent)
