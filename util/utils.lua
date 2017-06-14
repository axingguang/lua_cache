

local cjson = require "cjson"
local utils={}
utils.req=function(url,params)
	ngx.log(ngx.INFO,"回源请求URI："..url)
	ngx.log(ngx.INFO,"回源请求参数："..cjson.encode(params))
	local res = ngx.location.capture(url,
		{
			method = ngx.HTTP_POST,
			args=params
		}
	)
	local reply=''
	ngx.log(ngx.INFO,"回源返回信息："..res.body)
	if res.status == 200 then
		return res.body
	else
		ngx.log(ngx.ERR,"回源返回信息异常："..res.status)
		return '{"status":"300004500","message":"系统异常","result":null}'
	end
end

utils.redirect=function(url,params)
	ngx.log(ngx.INFO,"重定向回源请求URI："..url)
	ngx.log(ngx.INFO,"重定向回源请求参数："..cjson.encode(params))
	local pp=nil
	for k,v in pairs(params) do
		if pp==nil then
			pp=k..'='..v..'&'
		else
			pp=pp..k..'='..v..'&'
		end
	end
	if pp ~=nil then
		url=url..'?'..pp
	end
	ngx.redirect(domain_name.npms_base..url)
end


utils.back_resource=function(url,params)
	local cback=ngx.var.arg_callback
	if  init_conf.is_back_to_source  then 
		if  init_conf.back_to_source_type==1 then
			res = utils.req(url,{})
			if cback ~=nil  and cback ~='' then
				ngx.say(utils.jsonp(res,cback))
			else
				ngx.say(res)
			end
		else
			
			utils.redirect(url,params)
		end
	else
		if cback ~=nil and cback ~='' then
			ngx.say(utils.jsonp('{"status":"300004101","message":"数据查询失败或数据不正确","result":null}',cback))
		else
			ngx.say('{"status":"300004101","message":"数据查询失败或数据不正确","result":null}')
		end
	end
end

utils.to_result=function(res)
	local cback=ngx.var.arg_callback
	if cback ~=nil  and cback ~='' then
		ngx.say(utils.jsonp('{"status":"0","message":"","result":'..res..'}',cback))
	else
		ngx.say('{"status":"0","message":"","result":'..res..'}')
	end
end

utils.jsonp=function(res,c)
	return c.."("..res..")"
end

return utils
