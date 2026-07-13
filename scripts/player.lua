local player = {
	extends = CharacterBody3D,
}

function player:_ready()
	local PlayerStateController = require("PlayerStateController");
	local PlayerCamera = self:get_node("Camera/HorizontalPivot")
	PlayerStateController.new(self, PlayerCamera)
end;

function player:_process(dt)
	self:process(dt)
end;

function player:_physics_process(dt)
	self:physics_process(dt)
end;


return player
