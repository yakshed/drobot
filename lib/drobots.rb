module Drobots
end

Dir.glob(Drobot::BASEDIR.join('lib/drobots/**'), &method(:require))
