# config/boot.rb

#  Bloquear railties que no queremos
ENV["RAILS_SKIP_ACTIVE_RECORD"]  = "1"
ENV["RAILS_SKIP_ACTIVE_STORAGE"] = "1"
ENV["RAILS_SKIP_ACTIVE_JOB"]     = "1"
ENV["RAILS_SKIP_ACTION_MAILBOX"] = "1"
ENV["RAILS_SKIP_ACTION_TEXT"]    = "1"

require "bundler/setup"