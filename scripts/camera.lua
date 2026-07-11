local camera = {
	extends = Node3D;
	max_zoom = 30;
	zoom_speed = 1;
}

function camera:_ready()
	self.HPivot = self:get_node("./HorizontalPivot");
	self.VPivot = self:get_node("./HorizontalPivot/VerticalPivot");
	self.CameraSpring = self:get_node("./HorizontalPivot/VerticalPivot/CameraSpring");
	local StateController = require("StateController")
	local CameraStates = require("CameraStates")
	StateController.newCamera(self, CameraStates.Locked)
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
