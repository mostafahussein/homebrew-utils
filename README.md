## How do I install packages from here?

```sh
brew install mostafahussein/utils/name
```

You can also only add the tap which makes formulae within it
available in search results (`brew search` output):

```sh
brew tap mostafahussein/utils
```

Note: to clone the tap via SSH you will need to use:

```sh
brew tap mostafahussein/utils https://github.com/mostafahussein/homebrew-utils
```

## What packages are available?

With the following commands, you can install the latest generally available (GA) version of each product:
```sh
# Formulae

# aws-search-instances: A python script that takes in a list of instance-ids, private or public ipv4 addresses and searches for them in your AWS account. For the ones it finds, it creates a CSV file that contains the combined tags of all the instances.

brew install mostafahussein/utils/aws-search-instances
```
