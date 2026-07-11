local player = {
	extends = CharacterBody3D,
}

function player:_ready()
	local state_controller = require("StateController")
	local PlayerStates = require("PlayerStates")
	local player_camera = self:get_node("Camera/HorizontalPivot")
	state_controller.newPlayer(self, player_camera, PlayerStates.Idle)
end;

function player:_process(dt)
	self:process(dt)
end;

function player:_physics_process(dt)
	self:physics_process(dt)
end;


return player
