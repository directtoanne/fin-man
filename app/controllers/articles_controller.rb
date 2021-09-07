class ArticlesController < ApplicationController
  def scrape
    # @articles = []

    url = "https://emma-app.com/blog/category/tips-tricks/"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    @articles = []
    html_doc.search('.gridlove-post').each do |element|
      title = element.text.strip
      @articles << title
      # article = Article.create(title: title)
      # @articles.push(article)
    end
     articles = policy_scope(Article)

     authorize articles
 end
end
