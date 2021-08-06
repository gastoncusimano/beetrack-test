# Beetrack Test
Repo: https://github.com/gastoncusimano/beetrack-test
### Prerequisites to build the project

- Ruby 2.5.1
- Rails 5.2.5
- PostgreSQL
- Redis
- Yarn
- Node (14.16.0)

### Install the dependencies

```bash
$ bundle install
$ yarn install
```

Will be installed extra gems such as:
- rspec-rails (Testing)
- shoulda-matchers (Testing)
- dotenv (Environment vars)
- sidekiq & sidekiq-status (Background status)
- geocoder (Locate places using coordinates)

### Create a .env.development file to add your postgresql username and mapbox access token
```bash
DB_USER=your_postgres_username
MAPBOX_API_KEY=your_public_access_token_mapbox
```

### Create and setup the database

```bash
$ rails db:create db:migrate
```
### Run the tests

```bash
$ bundle exec rspec
```
### Run the server (each command on different terminals)

```bash
$ rails server
$ ./bin/webpack-dev-server
$ sidekiq
```
If you want to create a new location you can do it through:

POST http://localhost:3000/api/v1/gps

```json
{
  "latitude": 20.23,
  "longitude": -0.56,
  "sent_at": "2016-06-02 20:45:00",
  "vehicle_identifier": "HA-3452"
}
```
If you want to see the existing locations you can do it through:

http://localhost:3000/show

