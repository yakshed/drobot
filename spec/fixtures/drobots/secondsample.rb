require 'drobot'

module Drobots
  class Secondsample < Drobot
    def run
      @ran = true
    end
    def ran?
      @ran
    end
  end
end
