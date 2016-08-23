class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

	has_many :users 
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
	
end
