strongloop-node
===============
Cookbook to perform the initial configuration of a
[StrongLoop](http://strongloop.com/) loopback project. If no project name is
provided, the example app will be installed.

Requirements
------------
Platform:
* Ubuntu

Cookbooks:
* apt
* build-essential
* firewall
* nginx
* nodejs
* npm
* openssl
* supervisor

Attributes
----------
* `node['strongloop']['domain']`: Site domain
* `node['strongloop']['username']`: System user to create and setup StrongLoop
  with.
* `node['strongloop']['password']`: Password for
  `node['strongloop']['username']`. Alternatively the password hash for the
  user can be passed in a databag, or passed as a hash to the
  `node['strongloop']['shadow_hash']` attribute.`
* `node['strongloop']['project_name']`: Name of the LoopBack project to create.
  If no project name is provided, the example project will be created.
* `node['strongloop']['npm_pkgs']`: Additional npm packages to install for
  your project. These will be appended to your `packages.json` file.

The following SSL Configuration attributes are optional:
* `node[:strongloop][:ssl_cert]`: SSL Certificate to configure with `nginx`
* `node[:strongloop][:ssl_key]`: SSL Private Key to configure with `nginx`
* `node[:strongloop][:ssl_cacert]`: SSL CA Certificate to configure with
  `nginx`
* `node[:strongloop][:ssl_cert_path]`: Path to install
  `node[:strongloop][:ssl_cert]`.
* `node[:strongloop][:ssl_key_path]`: Path to install
  `node[:strongloop][:ssl_key]`
* `node[:strongloop][:ssl_cacert_path]`: Path to install
  `node[:strongloop][:ssl_cacert]`

Usage
-----
Add the `strongloop` recipe to your run list to setup the LoopBack project. Add
`strongloop::nginx` to your run list if you'd like a web server setup as well.

License & Authors
-----------------
- Author: Ryan Walker (<ryan.walker@rackspace.com>)
- Author: Brint O'Hearn (<brint.ohearn@rackspace.com>)

```
Copyright: 2013-2014, Rackspace

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
