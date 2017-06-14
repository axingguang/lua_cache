

ngx.header.content_type="application/json;charset=UTF-8"
-- ngx.header['Content-Type']="text/html;charset=UTF-8"

local cache = ngx.shared.cacheDict
ngx.say(cache:flush_expired())