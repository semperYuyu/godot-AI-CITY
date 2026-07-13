local player = {
	extends = CharacterBody3D,
}

function player:_ready()
	local StateController = require("StateController")
	local PlayerStates = require("PlayerStates")
	local PlayerCamera = self:get_node("Camera/HorizontalPivot")
	StateController.newPlayer(self, PlayerCamera, PlayerStates.Idle)
end;

function player:_process(dt)
	self:process(dt)
end;

function player:_physics_process(dt)
	self:physics_process(dt)
end;


return player
