

ngx.header.content_type="application/json;charset=UTF-8"
-- ngx.header['Content-Type']="text/html;charset=UTF-8"

local key = ngx.var.arg_key
local val = ngx.var.arg_value
local ex = ngx.var.arg_ex
if ex == nil 
	then ex=0
end
local cache = ngx.shared.cacheDict
local res,err,forcible = cache:set(key,val,ex)
ngx.say(val)