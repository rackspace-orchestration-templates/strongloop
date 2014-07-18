name              "redis-helper"
maintainer        "Brint O'Hearn"
maintainer_email  "brint.ohearn@rackspace.com"
license           "Apache 2.0"
description       "Sets up redis"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.0"

%w{ ubuntu centos debian fedora redhat }.each do |os|
  supports os
end

%w{ redisio }.each do |cb|
  depends cb
end
