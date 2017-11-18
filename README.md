# Akamai cloudlet manager

Akamai API for changes to Property Manager etc via CLI

[![Build Status](https://travis-ci.org/gouravtiwari/akamai-cloudlet-manager.svg?branch=master)](https://travis-ci.org/gouravtiwari/akamai-cloudlet-manager) [![Maintainability](https://api.codeclimate.com/v1/badges/9c35e419deec5c546f4e/maintainability)](https://codeclimate.com/github/gouravtiwari/akamai-cloudlet-manager/maintainability)

## Setup

#### Prerequisites
  These steps assume that you have ruby 2.3.1 or 2.4.2 installed

#### Steps

1. Get credentials in Akamai control panel (Luna)

https://developer.akamai.com/introduction/Prov_Creds.html

2. Once you get *New Credential Client Secret* copy them to local in ~/.edgerc file

It should resemble like this:

	[default]
	host = akaa-xxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxx.luna.akamaiapis.net
	client_token = akab-xxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxx
	client_secret = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	access_token = akab-xxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxx


3. Ensure you have bundler installed:

	```
	gem install akamai_cloudlet_manager
	```

## Akamai Cloudlet Manager: Power of CLI

This Gem provides a CLI, which makes akamai-cloudlet api calls very easy.

#### Get help
```sh
$ acm --help
// Lists all available commands
```

#### Updating a policy version

To update a policy version with new set of rules, these are series of steps you need to perform in order:

1. Get policy version

```
# Get all versions of a policy
acm get_policy_versions --policy-id=POLICY_ID
```

2. Clone policy version

```
# Clones the current policy version
acm clone_policy_version --policy-id=POLICY_ID
```

3. Update the cloned policy(draft policy)

```
acm update_policy_version --draft-version=DRAFT_VERSION --file-path=FILE_PATH --origin-id=ORIGIN_ID --policy-id=POLICY_ID --rule-name=RULE_NAME
```

Optional parameter to the above command are:
```
--rule_type, rule type, e.g. "albMatchRule"
--cookie_rules, from which cookie rules can be constructed and updated to policy version, e.g. "abc=xyz"
```

4. Activate policy version

Once rules look good in luna panel, you can activate policy to a given network(staging/production)
```
acm activate_policy_version --network=NETWORK --policy-id=POLICY_ID --version=VERSION
```
