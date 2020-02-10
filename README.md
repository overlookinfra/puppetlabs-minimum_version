# puppetlabs-minimum_version
This module is for use specifically with Puppet Enterprise, as it depends on the Package Manager capability in PE to inventory the currently installed versions of software packages.

## About minimum_version()
Return the package version for a given package that is at least the given minimum version
The function will compare the currently installed package with the given minimum version and:
- return the minimum version if the installed package is less than the minimum version, or not present
- return the installed version if the installed package is the same or newer than the minimum version
If the optional 'installversion' parameter is set, a different version than the minimum version can be returned

## Usage
```
# Ensure at least version 2.7.5-77.el7_6 of python is installed
package { 'python':
   ensure => minimum_version('python', '2.7.5-77.el7_6')
}
```

To install the latest version if the minimum version is not met:

```
# Ensure the latest version of python is installed if it is not at least version 2.7.5-77.el7_6
package { 'python':
  ensure => minimum_version('python', '2.7.5-77.el7_6', 'latest')
}
```

To specify a specific provider, you also have to provide a value for 'installversion':
```
# Ensure at least version 2.1.2 of the openssl gem is installed
package { 'openssl':
  ensure   => minimum_version('openssl', '2.1.2', '2.1.2', 'gem'),
  provider => gem
}
```

To specify all options:
```
# Ensure the latest version of the openssl gem is installed if it is not at least version 2.1.2
package { 'openssl':
   ensure   => minimum_version('openssl', '2.1.2', 'latest', 'gem'),
   provider => gem
}
```
