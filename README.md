# elastic_email_rails

*elastic_email_rails* is an Action Mailer adapter for using [Elastic Email](http://elasticemail.com/) in Rails apps. It uses the [Elastic Email HTTP API](https://elasticemail.com/support/http-api) internally.

## Installing

In your `Gemfile`

```ruby
gem 'elastic_email_rails'
```

## Usage

To configure your Elastic Email credentials place the following code in the corresponding environment file (`development.rb`, `production.rb`...)

```ruby
config.action_mailer.delivery_method = :elastic_email
config.action_mailer.elastic_email_settings = {
		api_key: '<elastic email api key>',
		username: '<elastic email username>'
}
```

Now you can send emails using plain Action Mailer:

```ruby
email = mail from: 'sender@email.com', to: 'receiver@email.com', subject: 'this is an email'
```

## TODO

* Upload attachments;
* CC and CCO;
# Channel.

This gem was based on [mailgun_rails](https://github.com/jorgemanrubia/mailgun_rails).



