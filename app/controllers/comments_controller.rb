class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    # TODO 通用化处理，抽离
    article = Article.find params[:article_id]
    comments = article.comments#.recent #.page(params[:page])

    items = comments.map do |comment|
      DataFormer.new(comment)
        .logic(:user_name)
        .url(:delete_url)
        .data
    end

    @component_data = {
      comments: items,
    }

    render json: {
      data: @component_data
    }

    #render "/react/page"
  end

  #def show
    #@page_name = "comment"
    #comment = Comment.find params[:id]

    #Rails.logger.debug comment

    #item = DataFormer.new(comment)
        #.url(:update_url)
        #.url(:delete_url)
        #.data

    #@component_data = {
      #comment: item
    #}

    #render "/react/page"
  #end

  #def new
    #ware_hash = {}
    #KcCourses::Ware.all.only(:id,:name).each do |ware|
      #ware_hash[ware.id] = ware.name
    #end

    #@page_name = "comment_new"
    #@component_data = {
      #wares: ware_hash,
      #create_url: comments_path,
    #}

    #render "/react/page"
  #end

  def create
    article = Article.find params[:article_id]
    comment = article.comments.new comment_params.merge(user_id: current_user.id.to_s)

    save_model(comment, "comment") do |_comment|
      DataFormer.new(_comment)
        .logic(:user_name)
        .url(:delete_url)
        .data
    end
  end

  #def edit
    #comment = Comment.find params[:id]
    #item = DataFormer.new(comment)
             #.logic(:ware_id)
             #.data

    #ware_hash = {}
    #KcCourses::Ware.all.only(:id,:name).each do |ware|
      #ware_hash[ware.id] = ware.name
    #end

    #@page_name = "comment_edit"
    #@component_data = {
      #comment: item,
      #wares: ware_hash,
      #update_url: comment_path(comment),
    #}

    #render "/react/page"
  #end

  #def update
    #comment = Comment.find(params[:id])

    #update_model(comment, comment_params, "comment") do |_comment|
      #DataFormer.new(_comment)
        #.url(:show_url)
        #.data
    #end
  #end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end

