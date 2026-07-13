local CameraStates = {
	extends = Node,
}

local function zoomCamera(camera, event)

	local springBlocked = camera.CameraSpring:get_hit_length() < camera.CameraSpring.spring_length

	if event:is_class("InputEventMouseButton") and event.pressed then
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and not springBlocked then
			camera.CameraSpring.spring_length = clamp(camera.CameraSpring.spring_length + camera.zoom_speed, 0, camera.max_zoom)
		elseif event.button_index == MOUSE_BUTTON_WHEEL_UP then
			camera.CameraSpring.spring_length = clamp(camera.CameraSpring.spring_length - camera.zoom_speed, 0, camera.max_zoom)
		end;
	end
	return;
end;

local function getMousePos(camera, event)
	if event:is_class("InputEventMouseMotion") then
		camera.mouse_delta = event.relative;
	end
end;

local function pivotCamera(camera)
	local limited_x = clamp(camera.VPivot.rotation.x - camera.mouse_delta.y * GlobalVariables.mouse_sensitivity, math.rad(-90), math.rad(90))
	camera.VPivot.rotation = Vector3(limited_x, 0, 0)
	camera.HPivot.rotation = Vector3(0, camera.HPivot.rotation.y - camera.mouse_delta.x * GlobalVariables.mouse_sensitivity, 0)
	camera.mouse_delta = Vector2.ZERO
end;

CameraStates.Locked = {
	Enter = function(self)
		print('camera is lock now')
		return;
	end;

	Exit = function(self)
		print('camera is unlockin')
		return;
	end;

	Input = function(self, event)
		zoomCamera(self, event)
		getMousePos(self, event)
	end;

	Update = function(self)
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE then
			self:switchState(CameraStates.Unlocked)
			return;
		end;
	end;

	Physics_Update = function(self, dt)
		pivotCamera(self, dt)
	end;
}

CameraStates.Unlocked = {
	Enter = function(self)
		print('camera is unlock now')
		return;
	end;

	Exit = function(self)
		print('camera is lockin')
		return;
	end;

	Input = function(self, event)
		zoomCamera(self, event)
	end;

	Update = function(self)
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED then
			self:switchState(CameraStates.Locked)
			return;
		end;
	end;

	Physics_Update = function(self)

	end;
}

return CameraStates;
