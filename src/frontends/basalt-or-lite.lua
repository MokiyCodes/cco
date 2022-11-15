-- basalt if we're in color, otherwise use lite
return (not term.isColor or not term.isColor()) and require 'frontends/lite' or require 'frontends/basalt'
