FROM ruby:3.3
ENV RAILS_ENV=production
WORKDIR /app
COPY . .
RUN gem install bundler && bundle install
EXPOSE 3001
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]