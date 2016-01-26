# Fenton Shell

Interacts with Fenton Server to download a signed SSH key for authentication to a server running OpenSSH 5.9+ and configured to use SSH Certificate authentication for the Fenton Project

[Fenton Project](https://fenton-project.github.io/) - SSH Key Management

## Production Deployment

Not recommended at this time

    `gem install fenton_shell -P MediumSecurity`

### Shell Completion

```
complete -F get_fenton_targets fenton
function get_fenton_targets()
{
  if [ -z $2 ] ; then
    COMPREPLY=(`fenton help -c`)
  else
    COMPREPLY=(`fenton help -c $2`)
  fi
}
```

## Developer Setup

#### Getting started

    git clone git@github.com:fenton-project/fenton_shell.git
    cd fenton_shell
    bundle install
    bundle exec ./bin/fenton

#### Ruby version

  See [gemspec](fenton_shell.gemspec)

#### System dependencies

  OpenSSH 5.9 or higher

#### Configuration

  Fenton creates configuration files here: `~/.fenton/`

#### How to run the test suite

    bundle exec rake test
    bundle exec rake features

#### Build documentation

    bundle exec rake yard
    bundle exec yard server

## Contributing

- Open an issue (please note if you'll be working on it or need assistance)
- Fork the project and do your work in a topic branch.
- Rebase your branch to make sure everything is up to date.
- Commit your changes & tests, then send a pull request.

## License

#### Author

  Nick Willever (<nickwillever@gmail.com>)

#### Copyright

  Copyright (c) 2013-2016 Nick Willever

#### License

Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
