local camera = {
	extends = Node3D;
	mouse_delta = Vector2.ZERO; -- just want to init it, doesn't need to be up here
	max_zoom = 20;
	zoom_speed = 2;
}

function camera:_ready()
	-- make sure to attach this to a parent node to the camera, the camera just needs to be offset with no script attached directly to it
	CAMERA_CLASS = require("camera_class")
	CAMERA_CLASS.new(self)
end
function camera:_input(event)
	self:process_mouse(event)
end


function camera:_physics_process(dt)
	self:pivot_camera(dt)
end
return camera
