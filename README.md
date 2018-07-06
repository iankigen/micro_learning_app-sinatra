## Micro Learning App

Micro-Learning app is a responsive web application that sends you one page per day about something you want to learn.

## Installation

- clone the application to you local machine

```
$ git clone https://github.com/iankigen/micro_learning_app-sinatra.git && cd micro_learning_app-sinatra
```

- Install application dependencies
```
$ bundle install
```

- Run the server
```
$ rackup
```

visit http://127.0.0.1:9292/ in your browser.


## Dependencies
- Object Relational Mapper (ORM)
```
gem 'activerecord', '~> 5.2'
gem 'sinatra-activerecord', '~> 2.0', '>= 2.0.13'
gem 'pg', '~> 1.0'
```
- Authentication
```
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
```
- News API
```
gem 'news-api', '~> 0.0.0'
```
- Testing
```
gem 'rack-test', '~> 1.0'
gem 'rake', '~> 12.3', '>= 12.3.1'
gem 'rspec', '~> 3.7'
```
- Flash
```
gem 'sinatra-flash', '~> 0.3.0'
```
- Sinatra
```
gem 'sinatra'
```
- Partials
```
gem 'sinatra-partial', '~> 1.0', '>= 1.0.1'
```

### Available Endpoints

| Endpoint | Description |
| ---- | --------------- |
| [GET /](#) | Home. |
| [GET /about](#) | About Page. |
| [GET /user/register](#) |  Register user.  |
| [GET /user/login](#) | Login user. |
| [GET /user/logout](#) | Logout user. |
| [POST /learn/add](#) | Add a category you are interested in learning |
| [GET /learn/](#) | List all items of categories you want to learn. |
| [GET /learn/delete](#) | Delete a category. |

## Done features

- Authentication 

## WIP features

- User Notification (Email)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iankigen/micro_learning_app-sinatra. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BubbleSort project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bubble_sort/blob/master/CODE_OF_CONDUCT.md).
