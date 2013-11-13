# case node["platform_family"]
#   when "debian"
# 
#     package "python-pysnmp4" do
#       action :install
#     end
#     
#     package "dpkg_package" do
#       action :install
#     end
# 
#   package "diamond" do
#       source "#{node["diamond"]["source_path"]}"
#       action :install
#       version node['diamond']['version']
#       notifies :restart, "service[diamond]"
#     end
# 
#   when "redhat"
#     include_recipe "yum::default"
#     
#     package "diamond" do
#       action :install
#       version node['diamond']['version']
#       notifies :restart, "service[diamond]"
#     end
# end

case node["platform_family"]
  when "debian"
    
      package "python-pysnmp4" do
        action :install
  end

    cookbook_file "#{node["diamond"]["cookbook_package"]["debian"]}" do
        action :create_if_missing
        backup false
        path "#{node["diamond"]["source_path"]}"
    end
    
    package "diamond" do
        source "#{node["diamond"]["source_path"]}"
        action :install
        notifies :restart, "service[diamond]"
    end


  when "redhat"
    include_recipe "yum::default"
   
    cookbook_file "#{node["diamond"]["cookbook_package"]["redhat"]}" do
        backup false
        path "#{node["diamond"]["source_path"]}"
    end
    
    package "diamond" do
        source "#{node["diamond"]["source_path"]}"
        action :install
        notifies :restart, "service[diamond]"
    end
end
