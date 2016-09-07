require 'rails_helper'

RSpec.describe Article, type: :model do
  it{
    is_expected.to validate_presence_of(:title)
  }

  it{
    is_expected.to validate_presence_of(:content)
  }

  it "参数" do
    @article = create(:article)
    expect(@article.respond_to?(:title)).to eq true
    expect(@article.respond_to?(:content)).to eq true
  end

  it "关系" do
    @article = create(:article)
    expect(@article.respond_to?(:articleable)).to eq true
  end
end

