--<< Services >>--
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")

local module = {}

--<< Generate a Unique User Id >>
function module:GenerateUUID(): string
	return HttpService:GenerateGUID(false):gsub("-","")
end

--<< Instance a New Value >>--
function module:MakeValue(Parent:Instance,Value:any,Name:string): ValueBase
	local Base = nil
	
	
	if typeof(Value) == "number" then
		Base = Instance.new("IntValue")
	elseif typeof(Value) == "string" then
		Base = Instance.new("StringValue")
	elseif typeof(Value) == "boolean" then
		Base = Instance.new("BoolValue")
	elseif typeof(Value) == "Vector3" then
		Base = Instance.new("Vector3Value")
	elseif typeof(Value) == "Color3" then
		Base = Instance.new("Color3Value")
	end
	
	if Base ~= nil then
		Base.Value = Value
		Base.Name = Name
		Base.Parent = Parent
	end
	
	return Base
end

--<< Returns Random Instance From Directory >>
function module:RandomInstance(Directory:Instance): Instance
	return Directory:GetChildren()[math.random(1,#Directory:GetChildren())]
end

--<< Plays Sound 💯 >>
function module:PlaySound(Parent:Instance,Sound:Sound): Sound
	assert(Parent and typeof(Parent) == "Instance","Invalid Parent")
	assert(Sound and typeof(Sound) == "Instance","Invalid Sound")
	
	local Clone = Sound:Clone()
	
	Clone.Parent = Parent
	Clone:Play()
	Debris:AddItem(Clone,Clone.TimeLength+1)
	
	return Clone
end


return module
