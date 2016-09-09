class ArticlesController < ApplicationController
  layout "new_version_base"

  def index
    articles = Article.page(params[:page]).per(2)
    items = articles.map do |article|
      DataFormer.new(article)
        .url(:show_url)
        .url(:update_url)
        .url(:delete_url)
        .data
    end

    @component_data = {
      articles: items,
      paginate: paginate_data(articles),
      next_page_url: articles_path,
    }

    respond_to do |f|
      f.html{
        @page_name = "articles"
        render "/react/page"
      }
      f.json{
        render json: {
          data: @component_data
        }
      }
    end
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

