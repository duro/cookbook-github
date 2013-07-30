action :create do
  path_to_key = "/home/#{new_resource.deploy_user}/.ssh/id_rsa"

  execute "generate deploy user keypair" do
    command "ssh-keygen -t rsa -N '' -C '#{new_resource.email}' -f #{path_to_key}"
    user new_resource.deploy_user
    group new_resource.deploy_user
    not_if { ::File.exists?(path_to_key)}
  end

  ruby_block "upload_key_to_github" do
    block do

      class Chef::Resource::RubyBlock
        include GithubAPI
      end

      upload_key(
        new_resource.endpoint,
        new_resource.email,
        new_resource.password,
        node[:fqdn],
        "#{path_to_key}.pub")
    end
  end
end