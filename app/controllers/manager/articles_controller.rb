class Manager::ArticlesController < Manager::ApplicationController
  def index
    @page_name = "manager_articles"
    manager_articles = Article.all.map do |manager_article|
      DataFormer.new(manager_article)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end

    @component_data = {
      manager_articles: manager_articles,
      create_url: manager_articles_path
    }

    render "/react/page"
  end

  def create
    manager_article = Article.new manager_article_params

    save_model(manager_article, "manager_article") do |_manager_article|
      DataFormer.new(_manager_article)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end
  end

  def update
    manager_article = Article.find(params[:id])

    update_model(manager_article, manager_article_params, "manager_article") do |_manager_article|
      DataFormer.new(_manager_article)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end
  end

  def destroy
    manager_article = Article.find(params[:id])
    manager_article.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def manager_article_params
      params.require(:manager_article).permit(:title, :content)
    end
end
