class TeamNode < Node
  belongs_to :node_object, class_name: 'Team'
  attr_accessible :parent_id, :node_object_id
  def self.table
    "teams"
  end

  def self.get(parent_id)
    nodes = Node.joins("INNER JOIN #{self.table} ON nodes.node_object_id = #{self.table}.id")
                .select('nodes.*')
                .where('nodes.type = ?', self)
    nodes.where("#{self.table}.parent_id = ?", parent_id) if parent_id
  end

  def get_name
    Team.find(self.node_object_id).name
  end

  def get_children(_sortvar = nil, _sortorder = nil, _user_id = nil, _parent_id = nil, _search = nil)
    TeamUserNode.get(self.node_object_id)
  end
end
