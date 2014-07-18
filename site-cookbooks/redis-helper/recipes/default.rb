if node['redis-helper']['run']
  include_recipe "redisio"
  include_recipe "redisio::enable"
end
