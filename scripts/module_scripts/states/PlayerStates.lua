local PlayerStates = {
	extends = Node,
}

local function attemptMovement()
	if (Input:is_action_pressed("MOVE_LEFT") or
	Input:is_action_pressed("MOVE_RIGHT") or
	Input:is_action_pressed("MOVE_FORWARD") or
	Input:is_action_pressed("MOVE_BACKWARD")) and
	GlobalVariables.global_interact then
		return true;
	end;

	return false;
end;

local function attemptJump()
	if Input:is_action_just_pressed("JUMP") and GlobalVariables.global_interact then
		return true;
	end;
	return false;
end;

local function allowMouseLockToggle()
	if Input:is_action_just_pressed("MENU") then
		Input.mouse_mode = Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and Input.MOUSE_MODE_CAPTURED;
	end;

	return;
end;

PlayerStates.Idle = {
	Enter = function (self)
		print('player is idle now')
		return;
	end;

	Exit = function (self)
		print('player is no longer idle')
		return;
	end;

	Update = function (self)
		if not self:is_on_floor() then
			self:switchState(PlayerStates.Fall)
			return;
		elseif attemptMovement() then
			self:switchState(PlayerStates.Walk)
			return;
		elseif attemptJump() and self:is_on_floor() then
			self:switchState(PlayerStates.Jump)
			return;
		end;
	end;

	Physics_Update = function (self)
		-- do nothing !
		allowMouseLockToggle()
	end;
}

PlayerStates.Walk = {
	Enter = function (self)
		print('omg player is walk')
		self.walkSpeed = 20
		return;
	end;

	Exit = function (self)
		print('aw player stop walk')
		self.walkSpeed = nil;
		return;
	end;

	Update = function (self, dt)
		if attemptJump() then
			self:switchState(PlayerStates.Jump)
			return;
		elseif not self:is_on_floor() then
			self:switchState(PlayerStates.Fall)
			return;
		elseif not attemptMovement() then
				self:switchState(PlayerStates.Idle)
			return;
		end;
	end;

	Physics_Update = function (self, dt)
		self.direction = Input:get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_FORWARD", "MOVE_BACKWARD"):normalized()
		self.velocity = self.camera.global_transform.basis * Vector3(self.direction.x, 0, self.direction.y) * self.walkSpeed
		self:move_and_slide()
		allowMouseLockToggle()
	end;
}

PlayerStates.Jump = {
	Enter = function (self)
		self.gravity = GlobalVariables.gravity;
		self.jumpStrength = 25;
		self.velocity = Vector3(self.velocity.x, self.velocity.y + self.jumpStrength, self.velocity.z)
		GlobalVariables.global_interact = false;
		return;
	end;

	Exit = function (self)
		self.gravity = nil;
		self.jumpStrength = nil;
		return;
	end;

	Update = function (self, dt)
			if self.jumpStrength <= 0 then
			self:switchState(PlayerStates.Fall)
			return;
		end;
	end;

	Physics_Update = function (self, dt)
		self.jumpStrength = self.jumpStrength - self.gravity * dt
		self:move_and_slide()
	end;
}

PlayerStates.Fall = {
	Enter = function (self)
		print('im falling !')
		self.gravity = GlobalVariables.gravity;
		GlobalVariables.global_interact = false;
		return;
	end;

	Exit = function (self)
		self.gravity = nil;
		self.velocity = Vector3.ZERO
		GlobalVariables.global_interact = true
		return;
	end;

	Update = function (self)
		if self:is_on_floor() then
			self:switchState(PlayerStates.Idle)
			return;
		end;
	end;

	Physics_Update = function (self, dt)
		self.velocity = Vector3(self.velocity.x, self.velocity.y - self.gravity * dt, self.velocity.z)
		self:move_and_slide()
	end;
}



return PlayerStates;
