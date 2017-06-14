

ngx.header.content_type="application/json;charset=UTF-8"
-- ngx.header['Content-Type']="text/html;charset=UTF-8"

local redisPool = require "redisPool2"
local utils = require "utils"
local key = 'S:PUBLIC_PRODUCT_API_PRODUCT_SALE_COM_ALL_N'
local res = redisPool.hget(init_conf.namespace,key)
if res==nil or res=='' then 
	utils.back_resource('/api/product/base/getAllSaleCom',{})
else
	utils.to_result(res)
end
