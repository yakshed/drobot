require 'drobot'

module Drobots
  class Firstsample < Drobot
    def run
      @ran = true
    end
    def ran?
      @ran
    end
  end
end
