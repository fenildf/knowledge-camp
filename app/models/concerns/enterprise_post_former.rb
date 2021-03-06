module EnterprisePostFormer
  extend ActiveSupport::Concern

  included do

    former 'EnterprisePositionLevel::Post' do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :number

      url :delete_url, ->(instance){
        manager_enterprise_post_path(instance)
      }

      url :update_url, ->(instance){
        manager_enterprise_post_path(instance)
      }

    end

  end
end
