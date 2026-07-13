local camera = {
	extends = Node3D;
}

function camera:_ready()
	local CameraStateController = require("CameraStateController")
	CameraStateController.new(self)
end

function camera:_input(event)
	self:input(event)
end;

function camera:_process(dt)
	self:process(dt)
end;


function camera:_physics_process(dt)
	self:physics_process(dt);
end
return camera
