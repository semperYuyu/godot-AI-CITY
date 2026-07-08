local npc = {
	extends = CharacterBody3D,
}

function npc:_ready()
	print("i am ready !")
	local state_controller = require("StateController")
	local npc_states = require("NPCStates")
	state_controller.new(self, npc_states.Idle)
end

function npc:_process(dt)
	self:process(dt)
end;

function npc:_physics_process(dt)
	self:physics_process(dt)
end;

return npc
