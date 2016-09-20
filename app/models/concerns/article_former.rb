module ArticleFormer
  extend ActiveSupport::Concern

  included do
    former "Article" do
      field :id, ->(instance) {instance.id.to_s}
      field :title
      field :content

      logic :ware_id, ->(instance) {
        instance.articleable_id.to_s if instance.articleable_is_ware?
      }

      url :update_url, ->(instance) {
        article_path(instance)
      }

      url :delete_url, ->(instance) {
        article_path(instance)
      }

      url :show_url, ->(instance) {
        article_path(instance)
      }

      url :manager_new_url, ->(instance) {
        new_manager_article_path(instance)
      }

      url :manager_edit_url, ->(instance) {
        edit_manager_article_path(instance)
      }

      url :manager_update_url, ->(instance) {
        manager_article_path(instance)
      }

      url :manager_delete_url, ->(instance) {
        manager_article_path(instance)
      }

      url :manager_show_url, ->(instance) {
        manager_article_path(instance)
      }
    end
  end
end
