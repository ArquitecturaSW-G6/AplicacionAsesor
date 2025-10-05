FROM ruby:3.2.9

WORKDIR /app

# Evita problemas de logger
RUN echo "require 'logger'" > /usr/local/lib/ruby/3.2.0/logger_fix.rb
ENV RUBYOPT='-r/usr/local/lib/ruby/3.2.0/logger_fix.rb'

COPY . .
RUN bundle install

EXPOSE 3001
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]
