# Fenton Shell

This is the CLI client that talks to [Fenton Server API](https://github.com/fenton-project/server-api)

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

* Ability to pass username, password during calls (ewww, maybe auth with private ssh key?)
* Generate private and public key for the user
* Create public key if user doesn't have one saved
* Ability to login to a server from signed keys
* Ability to configure an OpenSSH server to use the CA public key
* Validate this works on specific OpenSSH versions 5.9p+ most likely
* Validate this works on specific Operating Systems (CentOS, Ubuntu, Fedora, Amazon)
* Request generating a CA

## 0.2.0

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

# Contributing

- Fork the project and do your work in a topic branch.
- Rebase your branch to make sure everything is up to date.
- Commit your changes and send a pull request.

# License

[Fenton Project](http://fenton-project.github.io/) - SSH Key Management

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
