## Getting Started

Please create a separate feature branch for your submission. We use https://github.com/nvie/gitflow as the tool to help up manage feature development and releases. Once you are done with your feature branch, please create a pull-request and request for review.

### Prerequisites
- Postgres version 11.1 (https://postgresapp.com/)

### Installation
1. Clone repo
2. Run the following:
```
bundle install
rails db:create:all
```
3. Create a local dotenv file and populate with testing ENV vars (`POSTGRESQL_USERNAME` andd `POSTGRESQL_ADDRESS`)
4. Run `rails db:schema:load`
5. Seed your db by running `rails db:seed`
6. Start your server via `rails server`
7. Visit `http://0.0.0.0:3000/admin/login` and login using seeded email and password

## Testing

Run `rspec spec` to test your work
