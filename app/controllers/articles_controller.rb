require "yaml"

class ArticlesController < ApplicationController
  layout "new_version_base"

  def index
    articles = Article.page(params[:page]).per(2)
    items = articles.map do |article|
      DataFormer.new(article)
        .url(:show_url)
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
        .data

    @component_data = {
      article: item,
      comments_url: article_comments_path(article),
      create_comment_url: article_comments_path(article),
      signed_in: user_signed_in?,
      sign_in_url: sign_in_path
    }

    render "/react/page"
  end

  def landing
    data = YAML.load_file "config/landing.yml"

    @component_data = data["landing"]

    @page_name = "article_landing"

    render "/react/page", layout: "new_version_ware"
  end
end

