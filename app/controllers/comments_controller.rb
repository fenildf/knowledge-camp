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
  end

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

