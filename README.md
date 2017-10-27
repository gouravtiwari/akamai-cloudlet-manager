# akamai-api

Akamai API for changes to Property Manager etc via CLI

[![Build Status](https://travis-ci.org/gouravtiwari/akamai-cloudlet-updater.svg?branch=master)](https://travis-ci.org/gouravtiwari/akamai-cloudlet-updater)

## Setup

This step assumes you have ruby 2.3.1 install on local
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
	gem install bundler
	```

4. 	From this project directory, execute:

	```
	bundle install
	```

## Making API call

To check if setup is good, from the commandline, execute:

	ruby cloudlet.rb

Further details to be added

### To update matchrules:

1. Create a new policy version

  // Say Current version is 2

  cloudlet.create_policy_version('XXXXX', '2')

  // This updates and give us new version 3

2. Update Rules in new policy

  cloudlet.update_rules('XXXXX', '3')

3. Activate policy version on a network (staging/production)

  cloudlet.activate_policy_version('XXXXX', '3', 'staging')
