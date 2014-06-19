Description
===========

This is a template for deploying a single Linux server running
[StrongLoop](http://strongloop.com). StrongLoop Suite is a modern app platform
with Node.js, NPM and tooling for use in production. Backed by professional
support plans from StrongLoop.

Requirements
============
* A Heat provider that supports the Rackspace `OS::Heat::ChefSolo` plugin.
* An OpenStack username, password, and tenant id.
* [python-heatclient](https://github.com/openstack/python-heatclient)
`>= v0.2.8`:

```bash
pip install python-heatclient
```

We recommend installing the client within a [Python virtual
environment](http://www.virtualenv.org/).

Example Usage
=============
Here is an example of how to deploy this template using the
[python-heatclient](https://github.com/openstack/python-heatclient):

```
heat --os-username <OS-USERNAME> --os-password <OS-PASSWORD> --os-tenant-id \
  <TENANT-ID> --os-auth-url https://identity.api.rackspacecloud.com/v2.0/ \
  stack-create StrongLoop-Stack -f strongloop.yaml \
  -P flavor="4 GB Performance"
```

* For UK customers, use `https://lon.identity.api.rackspacecloud.com/v2.0/` as
the `--os-auth-url`.

Optionally, set environmental variables to avoid needing to provide these
values every time a call is made:

```
export OS_USERNAME=<USERNAME>
export OS_PASSWORD=<PASSWORD>
export OS_TENANT_ID=<TENANT-ID>
export OS_AUTH_URL=<AUTH-URL>
```

Parameters
==========
Parameters can be replaced with your own values when standing up a stack. Use
the `-P` flag to specify a custom parameter.

* `image`: Operating system to install (Default: Ubuntu 12.04 LTS (Precise
  Pangolin))
* `flavor`: Cloud server size to use. (Default: 2 GB Performance)
* `kitchen`: URL for the kitchen to clone with git. The Chef Solo run will copy
  all files in this repo into the kitchen for the chef run. (Default:
  https://github.com/rackspace-orchestration-templates/strongloop)
* `chef_version`: Chef client version to install for the chef run.  (Default:
  11.12.8)

Outputs
=======
Once a stack comes online, use `heat output-list` to see all available outputs.
Use `heat output-show <OUTPUT NAME>` to get the value fo a specific output.

* `private_key`: SSH private that can be used to login as root to the server.
* `server_ip`: Public IP address of the cloud server
* `strongloop_username`: Username to use when logging in via SSH to StrongLoop
  server.
* `strongloop_password`: Password to use with `strongloop_username` when
  logging in via SSH.
* `strongloop_url`: URL to use when navigating to the StrongLoop installation

For multi-line values, the response will come in an escaped form. To get rid of
the escapes, use `echo -e '<STRING>' > file.txt`. For vim users, a substitution
can be done within a file using `%s/\\n/\r/g`.

Stack Details
=============
#### Getting Started
This deployment provides a single Linux server with Node.js and the
StrongLoop command-line tool installed.

Once the deployment is complete, the LoopBack sample application is available
in the sls-sample-app sub-directory of your home directory. To access the
sample application, navigate to the IP address of the server on port 3000
(for example, https://1.2.3.4:3000). For more information, see the [LoopBack
documentation](http://docs.strongloop.com/display/DOC/LoopBack).

To create your own application, SSH to the server using the user and password
provided and follow the guides below. See
[docs.strongloop.com](http://docs.strongloop.com/) for more information about
StrongLoop Suite. Additionally, the private key provided in the passwords
section can be used to login as root via SSH. For information on how to use
SSH keys, please see these tutorials for [Mac OS X and
Linux](http://www.rackspace.com/knowledge_center/article/logging-in-with-a-ssh-private-key-on-linuxmac)
and [Windows using
PuTTY](http://www.rackspace.com/knowledge_center/article/logging-in-with-a-ssh-private-key-on-windows).

##### StrongLoop
[StrongLoop](http://strongloop.com/) provides an API tier for connecting
enterprise data to devices and browsers. StrongLoop Suite comes with a
private mBaaS, an operations and performance monitoring console, a
command-line tool and technical support from Node experts.

LoopBack is an open-source mobile backend framework built on Node.js that
enables you to connect mobile applications to your data. You can run LoopBack
on-premises or in the cloud. StrongLoop offers support, training and
professional services for LoopBack. StrongOps provides real-time performance
monitoring and operational support for Node.js applications with CPU
profiling, event loop inspection, and more.

##### Getting started with the LoopBack sample app
For more information see [Getting
Started](http://docs.strongloop.com/display/DOC/Getting+started#Gettingstarted-CreateyourfirstLoopBackapplication)

```
slc lb example
slc cd sls-sample-app
slc run .
```

##### Getting started with LoopBack from scratch
For more information see [Creating a LoopBack
Application](http://docs.strongloop.com/display/DOC/Creating+a+LoopBack+application)

```
mkdir myLoopBackProject
cd myLoopBackProject
slc project myLoopBackApp
slc lb model products
slc lb model customers
slc lb model stores
slc lb model cars
```

Contributing
============
There are substantial changes still happening within the [OpenStack
Heat](https://wiki.openstack.org/wiki/Heat) project. Template contribution
guidelines will be drafted in the near future.

License
=======
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
