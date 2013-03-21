maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "nmische@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs/Configures JavaLoader 1.1"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ centos redhat ubuntu }.each do |os|
  supports os
end

depends "coldfusion902"

recipe "default", "installs JavaLoader 1.1 and adds a ColdFusion mapping."
