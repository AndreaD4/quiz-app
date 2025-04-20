# frozen_string_literal: true

Devise.setup do |config|
  # ==> Security Extension
  # Configure security extension for devise

  # Password expires after a configurable time (in seconds).
  # Or expire passwords on demand by setting this configuration to `true`
  # Use `user.need_password_change!` to expire a password.
  # Setting the configuration to `false` will completely disable expiration checks.
  # config.expire_password_after = 3.months | true | false

  # Need 1 char each of: A-Z, a-z, 0-9, and a punctuation mark or symbol
  config.password_complexity = {digit: 1, lower: 1, symbol: 1, upper: 1}
  # config.password_regex = '^.*(?=.{8,})(?!.*\s)(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*$'

  # Number of old passwords in archive
  config.password_archiving_count = 5

  # Deny old password (true, false, count)
  config.deny_old_passwords = true

  # captcha integration for recover form
  # config.captcha_for_recover = true

  # captcha integration for sign up form
  # config.captcha_for_sign_up = true

  # captcha integration for sign in form
  # config.captcha_for_sign_in = true

  # captcha integration for unlock form
  # config.captcha_for_unlock = true

  # security_question integration for recover form
  # this automatically enables captchas (captcha_for_recover, as fallback)
  # config.security_question_for_recover = false

  # security_question integration for unlock form
  # this automatically enables captchas (captcha_for_unlock, as fallback)
  # config.security_question_for_unlock = false

  # security_question integration for confirmation form
  # this automatically enables captchas (captcha_for_confirmation, as fallback)
  # config.security_question_for_confirmation = false

  # ==> Configuration for :expirable
  # Time period for account expiry from last_activity_at
  config.expire_after = 2.months
end