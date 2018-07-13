config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'example.com',
  user_name:            'gmail_username',
  password:             'gmail_password',
  authentication:       'plain',
  enable_starttls_auto: true  }