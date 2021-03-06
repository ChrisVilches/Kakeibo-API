# Kakeibo (API)

Description of this project can be found here (frontend repository): https://github.com/ChrisVilches/Kakeibo-UI

## Ruby version

Check the `.ruby-version` file.

## System dependencies

1. If using sqlite, some system dependencies are required. For details: https://guides.rubyonrails.org/development_dependencies_install.html
2. Redis running on `localhost:6379` (for `sidekiq-scheduler`). It can be changed in `config/initializers/sidekiq.rb` (follow the Gem instructions: https://github.com/moove-it/sidekiq-scheduler).

## Database creation/initialization

```
bundle exec ridgepole -c config/database.yml --apply --env development
bundle exec ridgepole -c config/database.yml --apply --env test
bundle exec ridgepole -c config/database.yml --apply --env production
```

## Run the test suite

```
bundle exec rspec
```

## Services (job queues, etc.)

Scheduler being used for executing periodic jobs is `sidekiq-scheduler`. By default it needs Redis running on the default port on localhost.

Along with the main app, it's necessary to start one `sidekiq` process by executing:

```
bundle exec sidekiq
```

Environment variables needed:

```
# Backup file (texts like {year} will be replaced by the appropriate value):
BACKUP_OUTPUT_FILE=/home/my_username/backup-{year}-{month}-{day}.json

SUMMARY_EMAIL_CRON_STRING="* * * * *"
BACKUP_EMAIL_CRON_STRING="* * * * *"
BACKUP_TO_DISK_CRON_STRING="* * * * *"
```

Manage the process yourself. According to `sidekiq` (when trying to use deprecated options):

```
ERROR: Daemonization mode was removed in Sidekiq 6.0, please use a proper process supervisor to start and manage your services
ERROR: Logfile redirection was removed in Sidekiq 6.0, Sidekiq will only log to STDOUT
```

Some ideas on how to manage the process:

* https://github.com/mperham/sidekiq/wiki/Deployment
* https://github.com/seuros/capistrano-sidekiq/issues/212

## Configuration and deployment instructions

For now, deployment has to be done manually (capistrano setup is low priority for now).

1. Install using:

```
bundle install
```

2. Create a file called `.env`, copy the content of `.env.template` and edit accordingly.
3. Edit the `config/database.yml` file.
4. Execute database changes:

```
bundle exec ridgepole -c config/database.yml --apply --env production
```

5. Deploy the server:

```
RAILS_ENV=production bundle exec rails s -b 0.0.0.0 -p APP_PORT
```

Optionally, create a user manually in the Rails console:

```ruby
User.create!(email: 'testuser@host.com', password: 'qwerty123')
```

## Tools used

1. GraphQL
2. Devise (JWT)
3. Ridgepole
4. Rspec
5. RuboCop & RubyCritic
6. Sidekiq & Redis

And others.

## Development

Run all tests and linting:

```
bundle exec rake
```
