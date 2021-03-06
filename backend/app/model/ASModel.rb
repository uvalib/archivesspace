require_relative '../lib/realtime_indexing'

require_relative 'ASModel_crud'
require_relative 'ASModel_change_tracking'
require_relative 'ASModel_transfers'
require_relative 'ASModel_database_mapping'
require_relative 'ASModel_sequel'
require_relative 'ASModel_scoping'
require_relative 'ASModel_object_graph'
require_relative 'mixins/relationships'

require 'date'

module ASModel
  include JSONModel

  @@all_models = []

  def self.all_models
    @@all_models
  end

  def self.included(base)
    base.instance_eval do
      plugin :optimistic_locking
      plugin :validation_helpers
      plugin :after_initialize
    end

    base.extend(JSONModel)

    base.include(ChangeTracking)
    base.include(CRUD)
    base.include(RepositoryTransfers)
    base.include(DatabaseMapping)
    base.include(SequelHooks)
    base.include(ModelScoping)
    base.include(ObjectGraph)
    base.include(Relationships)

    base.extend(ClassMethods)

    @@all_models << base
  end


  module ClassMethods
    def top_level?
      respond_to?(:has_jsonmodel?) && has_jsonmodel? && my_jsonmodel.schema.has_key?('uri')
    end
  end

end


require_relative 'mixins/dynamic_enums'
