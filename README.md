# Spam notifications for slack

### Stack

- Ruby
- Rails in API Only mode
- Postgresql
- [Slack App](https://api.slack.com/apps/A04RU7S93BR)
- RSpec
- Rubocop

### API Doc

POST /api/v1/slack_notification

body -

```
{
  "RecordType": "Bounce",
  "Type": "SpamNotification",
  "TypeCode": 512,
  "Name": "Spam notification",
  "Tag": "",
  "MessageStream": "outbound",
  "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
  "Email": "zaphod@example.com",
  "From": "notifications@honeybadger.io",
  "BouncedAt": "2023-02-27T21:41:30Z"
}
```

response -

```
{
  "message": "Span notification successful"
}
```

### Demo

https://user-images.githubusercontent.com/68931/222752844-8722365f-c389-4c8d-ad94-f1d28e9d13e1.mov


### Tests

I've used RSpec to write a couple of integration tests for the API. The test at the moment uses the same credential for Slack. A better way to do it is, create a stub and return a mock api response.

```
$ bundle exec rspec
```

### Possible improvements

- Load the slack channel name form an environment var

### Credentials

This application makes use of Slack OAuth Token in order to communicate with Slack. I have generated a token and added it as a part of Rails credentials. Typically I generate a token per environment to keep the master.key safe for Production environments. However, for the sake of limiting time for this assignment, I have kept it simple. Please do the following once you have the master key to create or update the token -

```
$ bin/rails credentials:show
$ EDITOR="vim" bin/rails credentials:edit
```

### Deployment Instructions

These instructions are specific to heroku platform. We can configure our app to deployed via various methods like Capistrano, mina on platforms like AWS, but I will go with heroku for the same of this test.

First login to heroku cli and create an app within your directory -

```
$ heroku apps:create spam_notifications_slack
```

This will add a remote called `heroku` to your repository's git config.

Puma webserver comes built into Rails, so  we will just make use of that. Heroku relies on a Procfile to pickup whether we want to run a web process or a worker process. So, first modify or creae a `Procfile` and load Puma config in the web section of it:

```
web: bundle exec puma -C config/puma.rb
```

You can customize attributes like Max threads in your   `config/puma.rb`.

Generate a new master key in order to deploy the rails app to production ( in case you don't have one ) and add it to heroku.

```
heroku config:set RAILS_MASTER_KEY=<your-master-key-here>
```

Now it's just a matter of doing -

```
$ git push heroku main
```

And you have your endpoint deployed.
