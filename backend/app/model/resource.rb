class Resource < Sequel::Model(:resource)
  include ASModel
  corresponds_to JSONModel(:resource)

  include Identifiers
  include Subjects
  include Extents
  include Dates
  include ExternalDocuments
  include RightsStatements
  include Instances
  include Deaccessions
  include Agents
  include Trees
  include Notes
  include Relationships
  include ExternalIDs
  include CollectionManagements
  include UserDefineds
  include ComponentsAddChildren

  orderable_root_record_type :resource, :archival_object

  agent_relator_enum("linked_agent_archival_record_relators")

  tree_of(:resource, :archival_object)
  set_model_scope :repository

  define_relationship(:name => :spawned,
                      :json_property => 'related_accessions',
                      :contains_references_to_types => proc {[Accession]})

end