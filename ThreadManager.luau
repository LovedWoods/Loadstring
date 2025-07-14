--<< Modules >>--
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/LovedWoods/Loadstring/refs/heads/main/Functions.luau"))()

local module = {}
module.__index = module
module._Tasks = {}

function module:QueryTask(UUID:string,...): (string,thread)
	return self._Tasks[UUID]
end

function module:CancelTask(UUID:string,...): boolean
	local ThreadData = module:QueryTask(UUID)
	
	local s,e = pcall(function()
		return coroutine.close(ThreadData.Thread)
	end)
	
	return s
end

function module:PauseTask(UUID:string,...)
	local ThreadData = module:QueryTask(UUID)

	local s,e = pcall(function()
		return coroutine.yield(ThreadData.Thread)
	end)

	return s
end

function module:CreateTask(Object:thread,...): (string,thread)
	assert(Object and table.find({"function","thread"},typeof(Object):lower()) ~= nil,"Invalid Thread")
	
	local Thread = nil
	local UUID = Functions:GenerateUUID()
	
	if typeof(Object) == "function" then
		Thread = coroutine.create(Object)
	elseif typeof(Object) == "thread" then
		Thread = Object
	end
	
	pcall(coroutine.resume,Thread,...)
	
	self._Tasks[UUID] = {
		Thread = Thread :: thread,
		UUID = UUID :: string,
	};
	
	return UUID,Thread
end


function module.new(...)
	return setmetatable({},module)
end

return module
