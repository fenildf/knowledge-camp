require 'rails_helper'

RSpec.describe Comment, type: :model do
  it{
    is_expected.to validate_presence_of(:content)
  }

  it{
    is_expected.to validate_presence_of(:user)
  }

  it{
    is_expected.to validate_presence_of(:commentable)
  }

  it "参数" do
    @comment = create(:comment)
    expect(@comment.respond_to?(:content)).to eq true
    expect(@comment.respond_to?(:user_id)).to eq true
    expect(@comment.respond_to?(:commentable_id)).to eq true
    expect(@comment.respond_to?(:commentable_type)).to eq true
  end

  it "关系" do
    @comment = create(:comment)
    expect(@comment.respond_to?(:user)).to eq true
    expect(@comment.respond_to?(:commentable)).to eq true
  end

  it "scopes" do
    expect(Comment.respond_to?(:recent)).to eq true
  end

  describe User, type: :model do
    before do
      @user = create(:user)
    end

    it "关系" do
      expect(@user.respond_to?(:comments)).to eq true
    end
  end

  describe Article, type: :model do
    before do
      @article = create(:article)
    end

    it "关系" do
      expect(@article.respond_to?(:comments)).to eq true
    end
  end
end
