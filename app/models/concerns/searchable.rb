module Searchable
  extend ActiveSupport::Concern 

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  end

  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end
end