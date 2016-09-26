module CommentFormer
  extend ActiveSupport::Concern

  included do
    former "Comment" do
      field :id, ->(instance) {instance.id.to_s}
      field :content
      field :created_at

      logic :user_name, ->(instance) {
        instance.user.try :name
      }

      url :delete_url, ->(instance) {
        comment_path(instance)
      }

      url :manager_new_url, ->(instance) {
        new_manager_comment_path(instance)
      }

      url :manager_edit_url, ->(instance) {
        edit_manager_comment_path(instance)
      }

      url :manager_update_url, ->(instance) {
        manager_comment_path(instance)
      }

      url :manager_delete_url, ->(instance) {
        manager_comment_path(instance)
      }

      url :manager_show_url, ->(instance) {
        manager_comment_path(instance)
      }
    end
  end
end

