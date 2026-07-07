-- move this into state machine folder and change to match structure

local camera_class = {
	mouse_delta = Vector3.ZERO;
}

camera_class.new = function(camera)
	-- setmetatable(camera, { __index = camera_class}) <-- mimic this behaviour
	for key, value in pairs(camera_class) do
		if not camera[key] then
			camera[key] = value
		end
	end

	CAMERA_OBJECT = camera:get_node("Camera3D")
end;

camera_class.process_mouse = function(camera, event)
	-- this goes into _input, required for pivot_camera

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED then
		if event:is_class("InputEventMouseMotion") then
			camera.mouse_delta = event.relative
		end
	end

	if event:is_class("InputEventMouseButton") and event.pressed then
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN then
			local limited_z = clamp(CAMERA_OBJECT.position.z + camera.zoom_speed, 0, camera.max_zoom)
			CAMERA_OBJECT.position = Vector3(CAMERA_OBJECT.position.x, CAMERA_OBJECT.position.y, limited_z)
		elseif event.button_index == MOUSE_BUTTON_WHEEL_UP then
			local limited_z = clamp(CAMERA_OBJECT.position.z - camera.zoom_speed, 0, camera.max_zoom)
			CAMERA_OBJECT.position = Vector3(CAMERA_OBJECT.position.x, CAMERA_OBJECT.position.y, limited_z)
		end
	end
end;

camera_class.pivot_camera = function(camera, dt)
	-- this goes into _physics_process, requires process_mouse
	local delta = camera.mouse_delta or Vector2.ZERO
	local limited_x = clamp(camera.rotation.x - delta.y * dt, math.rad(-90), math.rad(90))
	camera.rotation = Vector3(limited_x, camera.rotation.y - delta.x * dt, 0)
	camera.mouse_delta = Vector2.ZERO;

end;

return camera_class;
