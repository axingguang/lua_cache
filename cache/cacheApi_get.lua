

ngx.header.content_type="application/json;charset=UTF-8"
-- ngx.header['Content-Type']="text/html;charset=UTF-8"

local key = ngx.var.arg_key
local cache = ngx.shared.cacheDict
local val = cache:get(key)
ngx.say(val)