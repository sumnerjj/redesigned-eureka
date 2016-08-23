class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :facebook_id, :auth_token
end
