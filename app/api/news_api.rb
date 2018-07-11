require 'news-api'

class NewsApi
  def initialize
    @news_api = News.new('77cf0019ddac41acb887527a1c06111c')
  end

  def fetch_articles(query)
    @news_api.get_top_headlines(q: query,
                                language: 'en',
                                page: 1,
                                sortBy: 'popularity')
  end
end