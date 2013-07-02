
actions :create

def initialize(*args)
  super
  @action = [:create]
end

attribute :deploy_user, :kind_of => String, :name_attribute => true
attribute :endpoint, :kind_of => String, :default => "/user/keys"
attribute :username, :kind_of => String
attribute :email, :kind_of => String
attribute :password, :kind_of => String
