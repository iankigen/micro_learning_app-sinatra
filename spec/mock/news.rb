class MockNewsApi
  def initialize(title = 'title', description = 'description', author = 'author', url = 'url')
    @title = title
    @description = description
    @author = author
    @url = url
  end

  def urlToImage
    url
  end

  attr_reader :title, :description, :author, :url
end

class NewsApiMock
  def get_everything(*_args)
    [MockNewsApi.new]
  end

  def get_top_headlines(*_args)
    [MockNewsApi.new]
  end
end
