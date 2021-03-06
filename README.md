# lita-gsuite

A lita plugin for interacting with a GSuite account.

By design, only read-only access is requested. This is intended to provide some visibility
into the account, not provide administrative functions.

This was written for a GSuite account with ~125 active users. It may not scale
well to larger accounts, but feedback and optimisations are welcome.

## Getting Started

### 1. Installation

Add this gem to your lita installation by including the following line in your Gemfile:

    gem "lita-gsuite"

### 2. Configuration

The lita bot requires an OAuth client ID and secret before it can initiate
the process to generate an OAuth2 token for each user. That requires an OAuth2
client ID and secret.

Both values must be added to your lita\_config.rb. Both are sensitive, so using
ENV vars is recommended to keep the values out of version control.

    config.handlers.gsuite.oauth_client_id = ENV["GOOGLE_CLIENT_ID"]
    config.handlers.gsuite.oauth_client_secret = ENV["GOOGLE_CLIENT_SECRET"]

You can generate the ID and secret on the [Google Developers
Console](https://console.developers.google.com/), and Google has [some
documentation](https://developers.google.com/identity/protocols/OAuth2).

You should be given the opportunity to view the new ID and secret. Be sure to copy them
down, as they can't be retrieved again later.

Once the handler is configured and running, each user that wants to interact with it
will be prompted to complete an OAuth authorisation process before they can start. This
generates an API token that's specific to them and will be used to make API calls on
their behalf.

### 3. Enable Google API

The GSuite API must be explicitly enabled for your account:

1. Sign in to https://admin.google.com
2. Visit the Security tab, click "API reference" and "Enable API Access"

### 4. Authorising and First Commands

With the installation and configuration complete, restart your lita bot.

Open your chat interface, and issue the following commands the bot.

1. Initiate authentication for your user: `lita gsuite auth`
2. Provide your unique token to lita-gsuite: `lita gsuite set-token <token-generated-in-previous-step>`
3. Fetch an account summary: `lita gsuite account-summary`

All going well, you should see a summary of your gsuite account printed in the channel.

## Chat commands Reference

### Administrators

Display a summary of the GSuite account - organisation name, contant details,
alternative email address, etc.

    lita gsuite account-summary

### Administrators

List users with super or delegated administrative privileges, and their two-factor
auth status.

    lita gsuite list-admins

### Empty Groups

List groups with no members.

    lita gsuite empty-groups

### Inactive Users

List active users that haven't logged in for 8 weeks.  This may be helpful for
identifying accounts that should be suspended or deleted.

    lita gsuite suspension-candidates

### Suspended Users

List suspended users that haven't logged in for 26 weeks. This may be helpful
for identifying accounts that have been suspended for a long time and may be
candidates for deletion.

    lita gsuite deletion-candidates

### User with No Organisational Unit

List users not assigned to an Organisational Unit.

    lita gsuite no-ou

### Two Factor Authentication

Print key stats on Second Factor Authentication uptake.

    lita gsuite two-factor-stats

### Two Factor Authentication Disabled

Print users within an Organisational Unit that don't have Second Factor Authentication enabled.

    lita gsuite two-factor-off /OUPATH

## Periodic Updates

To help monitor the above reports automatically, it's possible to schedule them to be printed in
a channel periodically.

List the reports that will periodically print in the current channel:

    lita gsuite schedule list

List the reports that are available to print periodically:

    lita gsuite schedule commands

Schedule a weekly report in the current channel, specified in UTC time:

    lita gsuite schedule add-weekly <day-of-the-week> HH:MM <report-name>
    lita gsuite schedule add-weekly wednesday 01:00 list-admins
    lita gsuite schedule add-weekly monday 13:45 no-ou

Schedule a time-window report that will run regularly and print output when
new data is available:

    lita gsuite schedule add-window <report-name>
    lita gsuite schedule add-window list-activities

Delete a scheduled report from the current room. The ID can be find in the
output of "schedule list":

    lita gsuite schedule del <id>
