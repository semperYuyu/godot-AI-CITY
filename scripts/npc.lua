local npc = {
	extends = CharacterBody3D,
}

function npc:_ready()
	local NPCStateController = require("NPCStateController")
	NPCStateController.new(self)
end

function npc:_process(dt)
	self:process(dt)
end;

function npc:_physics_process(dt)
	self:physics_process(dt)
end;

return npc
