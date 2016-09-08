class ArticlesController < ApplicationController
  layout "new_version_base"

  def index
    @page_name = "articles"
    articles = Article.all.map do |article|
      DataFormer.new(article)
        .url(:show_url)
        .url(:update_url)
        .url(:delete_url)
        .data
    end

    @component_data = {
      articles: articles,
      create_url: articles_path
    }

    render "/react/page"
  end

  def show
    @page_name = "article"
    article = Article.find params[:id]

    item = DataFormer.new(article)
        .url(:update_url)
        .url(:delete_url)
        .data

    @component_data = {
      article: item
    }

    render "/react/page"
  end
end

