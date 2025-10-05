FROM ruby:3.3
ENV RAILS_ENV=development

WORKDIR /app

COPY . .

RUN gem install bundler && bundle install

EXPOSE 3001
CMD ["bash", "-c", "bundle exec rails server -b 0.0.0.0 -p 3001"]
