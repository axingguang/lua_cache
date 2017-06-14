
redisPool2={
	config={
		auth='letvsc@2015',
		db=10,
		timeout=1000,
	}


}
local parser = require("redis.parser")
--local json = require("cjson")
redisPool2.hget=function(key,field)

	ngx.log(ngx.INFO,"读取redis参数："..key..">>>"..field)
	local res = ngx.location.capture('/redis',
		{
			args={
				n=3,
				cmds='auth '..redis_config.auth..'\r\nselect '..redis_config.db..'\r\nhget '..key..' '..field..'\r\n',
			}
		}
	)
	local reply=''
	if res.status == 200 then
		reply = parser.parse_replies(res.body,3)
		--local value=json.encode(res.body)
		return reply[3][1]
	else
		ngx.log(ngx.ERR,"读取redis失败："..res.status)
	end
end
return redisPool2
