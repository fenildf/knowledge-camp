class Manager::ArticlesController < Manager::ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @page_name = "manager_articles"
    manager_articles = Article.page(params[:page])

    items = manager_articles.map do |manager_article|
      DataFormer.new(manager_article)
        .url(:manager_new_url)
        .url(:manager_show_url)
        .url(:manager_delete_url)
        .url(:manager_edit_url)
        .data
    end

    @component_data = {
      manager_articles: items,
      manager_new_url: new_manager_article_path,
      paginate: DataFormer.paginate_data(manager_articles)
    }

    render "/react/page"
  end

  def show
    @page_name = "manager_article"
    manager_article = Article.find params[:id]

    Rails.logger.debug manager_article

    item = DataFormer.new(manager_article)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data

    @component_data = {
      manager_article: item
    }

    render "/react/page"
  end

  def new
    ware_hash = {}
    KcCourses::Ware.all.only(:id,:name).each do |ware|
      ware_hash[ware.id] = ware.name
    end

    @page_name = "manager_article_new"
    @component_data = {
      wares: ware_hash,
      manager_create_url: manager_articles_path,
    }

    render "/react/page"
  end

  def create
    manager_article = Article.new manager_article_params

    save_model(manager_article, "manager_article") do |_manager_article|
      DataFormer.new(_manager_article)
        .url(:manager_show_url)
        .data
    end
  end

  def edit
    article = Article.find params[:id]
    item = DataFormer.new(article)
             .logic(:ware_id)
             .data

    ware_hash = {}
    KcCourses::Ware.all.only(:id,:name).each do |ware|
      ware_hash[ware.id] = ware.name
    end

    @page_name = "manager_article_edit"
    @component_data = {
      article: item,
      wares: ware_hash,
      manager_update_url: manager_article_path(article),
    }

    render "/react/page"
  end

  def update
    manager_article = Article.find(params[:id])

    update_model(manager_article, manager_article_params, "manager_article") do |_manager_article|
      DataFormer.new(_manager_article)
        .url(:manager_show_url)
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
      params.require(:manager_article).permit(:title, :content, :ware_id)
    end
end
