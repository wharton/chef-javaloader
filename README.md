Description
===========

Installs the JavaLoader framework for ColdFusion.

Requirements
============

Cookbooks
---------

coldfusion902

Attributes
==========

* `node['javaloader']['install_path']` (Default is /vagrant/frameworks)
* `node['javaloader']['owner']` (Default is `nil` which will result in owner being set to `nobody`)
* `node['javaloader']['group']` (Default is bin)
* `node['javaloader']['download']['url']` (Default is http://javaloader.riaforge.org/downloads/javaloader_v1.1.zip)

Usage
=====

On ColdFusion server nodes:

    include_recipe "javaloader"


