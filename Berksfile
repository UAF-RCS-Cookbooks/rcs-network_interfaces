source 'https://supermarket.chef.io'
source :chef_server

metadata

group :integration do
  cookbook 'net_setup', path: './test/fixtures/cookbooks/net_setup'
  cookbook 'fake', path: './test/fixtures/cookbooks/fake'
end