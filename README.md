# Fenton Shell

This is the CLI client that talks to Fenton Server

# Status

Alpha, do not use this unless you are developing the app

Version - Check lib/fenton/version.rb

# Getting Started

Clone, Bundle, Run

    git clone git@github.com:fenton-project/server-api.git
    cd server-api
    bundle install
    fenton

# Roadmap

## 0.1.0

* Create public key if user doesn't have one saved
* Generate private and public key for the user
* Ability to login to a server from signed keys
* Ability to configure an OpenSSH server to use the CA public key
* Validate this works on specific OpenSSH versions 5.9p+ most likely
* Validate this works on specific Operating Systems (CentOS, Ubuntu, Fedora, Amazon)
* Request generating a CA

## 0.2.0

* Ability to pass username, password during calls (ewww, maybe auth with private ssh key?)
* Requests to generate teams, projects, users, roles
* Ability to see your teams and projects
* Request that brings down what the sshd_config will look like per team and/or project
* Manage each signed certificate for each team/project (hmm research this one)

## 0.3.0

* Create a local configuration file for your Fenton Server

## 0.4.0

* Ability to send requests to revoke keys
* Ability to see who has requested access

## 0.5.0

* Package application as operating system native packages (rpm, deb, etc..)

# Fenton Project

To manage SSH Keys in a centralized manner

## Why?

User management is boring and tedious, it comes down to one thing, someone you trust needs to get access to your servers.  What do you do?  For loop with ssh -n FTW.  And what about when you stop trusting that person? Yeah... and when you have utility computing everywhere doing that loop a couple times a day or even through a configuration management tool is not worth the trouble.

Instead use SSH Certificates they allow you to configure a server for trusting signed user SSH keys.  It will allow you to:
* Sign them for specific time period
* Revoke them
* Option to share 1 account or give each user their own account
* Great for vendors, contractors, etc...
* Great for machine access like nagios and others
* Can force commands without the problem of SFTP and such
* Can lock the signed key to specific hosts and where the hosts are being accessed from

Here's the basics: 
* Create a CA private & public key
* Add the CA public key to the server that is needing to be accessed
* Sign the user's public ssh key with the CA private key (creates a file <privatekey>-cert.pub)
* They can now ssh with their private key because of the *-cert.pub file

# Contributing

- Fork the project and do your work in a topic branch.
- Rebase your branch to make sure everything is up to date.
- Commit your changes and send a pull request.

# License

Fenton - SSH Key Management

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Nick Willever (<nickwillever@gmail.com>) |
| **Copyright:**       | Copyright (c) 2013 Nick Willever         |
| **License:**         | Apache License, Version 2.0              |

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
