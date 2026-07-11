local camera = {
	extends = Node3D;
}

function camera:_ready()
	local StateController = require("StateController")
	local CameraStates = require("CameraStates")
	StateController.newCamera(self, CameraStates.Locked)
end

function camera:_process(dt)
	self:process(dt);
end;


function camera:_physics_process(dt)
	self:physics_process(dt);
end
return camera
