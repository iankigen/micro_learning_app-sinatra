require 'rufus-scheduler'
require 'pony'
require 'news-api'

Dir.glob('./app/{models, helpers}/*.rb').each { |file| require file }

Pony.options = {
  from: 'no-reply@site.com',
  headers: { 'Content-Type' => 'text/html' },
  subject: 'LEARN',
  via: :smtp,
  via_options: {
    address: 'smtp.gmail.com',
    port: '587',
    enable_starttls_auto: true,
    user_name: ENV['SMTP_EMAIL'],
    password: ENV['SMTP_PASSWORD'],
    authentication: :plain,
    domain: ENV['DOMAIN_NAME']
  }
}

def send_mail
  news_api = News.new(ENV['KEY'])

  users = Users.all
  users.each do |user|
    categories = Categories.where(users_id: user.id)
    next unless categories.first
    q = categories[rand(categories.length).to_i].name
    news = news_api.get_top_headlines(q: q,
                                        language: 'en',
                                        page: 1,
                                        sortBy: 'popularity')
    top_headline = news[rand(news.length).to_i]
    Pony.mail(to: user.email,
              body: "<div>
    <h1>#{top_headline.title}</h1>
    <img src='#{top_headline.urlToImage}' class='img-fluid' alt=''>
    <p class='blog-post-meta'>#{top_headline.author}</p>
    <p>#{top_headline.description}</p>
    <a class='btn btn-outline-success' href='#{top_headline.url}'>Learn More</a>
    </div>
    ")
  end
end

puts '=' * 10
puts 'scheduler running'
puts '=' * 10

scheduler = Rufus::Scheduler.new

scheduler.cron '0 0 6 * * *' do
  # do something every day 6.am
  puts '>' * 5
  puts 'mail sent'
  send_mail
end

scheduler.join
