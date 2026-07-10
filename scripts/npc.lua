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

function npc:_on_player_detect_area_body_entered(body)
	self.target = body;
end

function npc:_on_player_detect_area_body_exited()
	self.target = nil;
end

return npc
