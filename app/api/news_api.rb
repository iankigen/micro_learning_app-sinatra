require 'news-api'

class NewsApi
  def initialize
    @news_api = News.new(ENV['KEY'])
  end

  def fetch_articles(query)
    @news_api.get_top_headlines(q: query,
                                language: 'en',
                                page: 1,
                                sortBy: 'popularity')
  end
end